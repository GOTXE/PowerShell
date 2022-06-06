# IMPORTAR CSV y crear array con los datos del csv

$hostlist = import-csv "C:\temp\hosts.csv"

$hosts = @()
$nombres = @()
$estado =@()
$hostlist | ForEach-Object {
$hosts += $_.host
$nombres += $_.nombre
}

$numero = Read-Host "numero"

write-host $($hosts[$numero],$nombres[$numero])

$resultado =foreach ($ip in $hosts) {
    $estado += Test-Connection -ComputerName $ip -Count 1 -Quiet
    
} 

$cuentaArray = $hostlist.Count
Write-Host "Total cuenta valores array = $cuentaArray"

for ($i = 0; $i -lt $hosts.Count; $i++) {
    write-host "$($hosts[$i]) > $($nombres[$i]) > $($estado[$i])"
    
}

Write-Host $($hosts[0])

