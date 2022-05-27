
## Functions
function Show-Menu
{
 param (
 [string]$Title = 'Scan Menu'
 )
 cls
 Write-Host "================ $Title ================"
 Write-Host "Connectivity test (Ping only): Press '1' for this option."
 Write-Host "TCP connectivity test for responding hosts (Ping test first): Press '2' for this option."
 Write-Host "TCP connectivity test for all hosts: Press '3' for this option."
 Write-Host "Q: Press 'Q' to quit."
}
function connectivity-test
{
 param (
 [string]$IPAddress,
 [int]$scantype,
 [int]$portnumber
 )
 if (($scantype -eq 1) -OR ($scantype -eq 2))
 {
 $testresult = Test-Connection $IPAddress -Quiet
 if ($testresult -eq $true)
 {
 if ($scantype -eq 1)
 {
 $message = "Host " + $IPAddress + " is responding";
 Write-Host $message -ForegroundColor black -BackgroundColor green
 }
 if ($scantype -eq 2)
 {
 $testresulttcp = Test-NetConnection -Computer $IPAddress -Port $portnumber
 if ($testresulttcp.TCPTestSucceeded -eq $true)
 {
 $message = "Host " + $IPAddress + " is listening on TCP/" + $portnumber + "";
 Write-Host $message -ForegroundColor black -BackgroundColor green
 }
 }
 }
 }
 else
 {
 $testresulttcp = Test-NetConnection -Computer $IPAddress -Port $portnumber
 if ($testresulttcp.TCPTestSucceeded -eq $true)
 {
 $message = "Host " + $IPAddress + " is listening on TCP/" + $portnumber + "";
 Write-Host $message -ForegroundColor black -BackgroundColor green
 }
 }
}
   
function Get-IPs {
   
 Param(
 [Parameter(Mandatory = $true)]
 [array] $Subnets
 )
   
foreach ($subnet in $subnets)
 {
   
 #Split IP and subnet
 $IP = ($Subnet -split "\/")[0]
 $SubnetBits = ($Subnet -split "\/")[1]
   
 #Convert IP into binary
 #Split IP into different octects and for each one, figure out the binary with leading zeros and add to the total
 $Octets = $IP -split "\."
 $IPInBinary = @()
 foreach($Octet in $Octets)
 {
 #convert to binary
 $OctetInBinary = [convert]::ToString($Octet,2)
   
 #get length of binary string add leading zeros to make octet
 $OctetInBinary = ("0" * (8 - ($OctetInBinary).Length) + $OctetInBinary)
   
 $IPInBinary = $IPInBinary + $OctetInBinary
 }
 $IPInBinary = $IPInBinary -join ""
   
 #Get network ID by subtracting subnet mask
 $HostBits = 32-$SubnetBits
 $NetworkIDInBinary = $IPInBinary.Substring(0,$SubnetBits)
   
 #Get host ID and get the first host ID by converting all 1s into 0s
 $HostIDInBinary = $IPInBinary.Substring($SubnetBits,$HostBits) 
 $HostIDInBinary = $HostIDInBinary -replace "1","0"
   
 #Work out all the host IDs in that subnet by cycling through $i from 1 up to max $HostIDInBinary (i.e. 1s stringed up to $HostBits)
 #Work out max $HostIDInBinary
 $imax = [convert]::ToInt32(("1" * $HostBits),2) -1
   
 $IPs = @()
   
 #Next ID is first network ID converted to decimal plus $i then converted to binary
 For ($i = 1 ; $i -le $imax ; $i++)
 {
 #Convert to decimal and add $i
 $NextHostIDInDecimal = ([convert]::ToInt32($HostIDInBinary,2) + $i)
 #Convert back to binary
 $NextHostIDInBinary = [convert]::ToString($NextHostIDInDecimal,2)
 #Add leading zeros
 #Number of zeros to add
 $NoOfZerosToAdd = $HostIDInBinary.Length - $NextHostIDInBinary.Length
 $NextHostIDInBinary = ("0" * $NoOfZerosToAdd) + $NextHostIDInBinary
   
 #Work out next IP
 #Add networkID to hostID
 $NextIPInBinary = $NetworkIDInBinary + $NextHostIDInBinary
 #Split into octets and separate by . then join
 $IP = @()
 For ($x = 1 ; $x -le 4 ; $x++)
 {
 #Work out start character position
 $StartCharNumber = ($x-1)*8
 #Get octet in binary
 $IPOctetInBinary = $NextIPInBinary.Substring($StartCharNumber,8)
 #Convert octet into decimal
 $IPOctetInDecimal = [convert]::ToInt32($IPOctetInBinary,2)
 #Add octet to IP
 $IP += $IPOctetInDecimal
 }
   
 #Separate by .
 $IP = $IP -join "."
 $IPs += $IP
   
   
 }
 $IPs
 }
}
   
   
## Main Code
do
{
 $IPSubnets = Read-Host "What are your IP ranges to scan? (Example: 10.31.16.0/22,192.168.0.1/24)"
 Show-Menu
 $input = Read-Host "Please make a selection"
 switch ($input)
 {
 '1' {
 cls
 Get-IPs -Subnets $IPSubnets | % {connectivity-test $_ 1 0}
 } '2' {
 cls
 $port = Read-Host "What is the TCP Port to scan?)"
 cls
 Get-IPs -Subnets $IPSubnets | % {connectivity-test $_ 2 $port}
 } '3' {
 cls
 $port = Read-Host "What is the TCP Port to scan?)"
 cls
 Get-IPs -Subnets $IPSubnets | % {connectivity-test $_ 3 $port}
 } 'q' {
 return
 }
 }
 pause
}
until ($input -eq 'q')
