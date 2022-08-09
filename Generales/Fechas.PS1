## Comparando fechas

$fecha_ini = "2020/08/04"
$fecha = (get-date).ToString("yyyy/MM/dd")

Write-Output $fecha_ini
Write-Output $fecha

if ($fecha_ini -lt $fecha){
    
    Write-Output "Fecha mas nueva"

} else {
    
    Write-Output "pues no es mas nueva"
}
