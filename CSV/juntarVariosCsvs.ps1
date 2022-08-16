# Juntar varios csv en uno 
# Primero nombrar por orden los csv que se quieren unir

$folderCsv = PATH\
$nombreCsvNuevo = Nombre.csv
$pathCsvNuevo = $folderCsv + $nombreCsvNuevo


Get-Content -Filter *.csv -Path $folderCsv*.csv | Add-Content -path nombre.csv
