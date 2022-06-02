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

Write-Host $($hosts[$numero],$nombres[$numero],$estado[$numero])



