
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

    $ping = Test-Connection -ComputerName $ip -ErrorAction SilentlyContinue -Count 1 -Quiet 

    if ($ping -eq "True") {
        $estado += "Online"
    } else {
        $estado += "Offline"
    }
    
} 

for ($i = 0; $i -lt $hosts.Count; $i++) {
    write-host "$($hosts[$i]) > $($nombres[$i]) > $($estado[$i])"
    
}
