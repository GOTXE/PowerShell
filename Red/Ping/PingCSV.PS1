
Clear-host

$hostlist = import-csv "C:\temp\hosts.csv"

$hosts = @()
$nombres = @()
$estado =@()
$hostlist | ForEach-Object {
$hosts += $_.host
$nombres += $_.nombre
}


foreach ($ip in $hosts) {

    Test-Connection -ComputerName $ip -Count 1 -Quiet 

    if ($ip -eq "True") {
        $estado += "Online"
    } else {
        $estado += "Offline"
    }
    
} 

for ($i = 0; $i -lt $hosts.Count; $i++) {
    write-host "$($hosts[$i]) > $($nombres[$i]) > $($estado[$i])"
    
}
