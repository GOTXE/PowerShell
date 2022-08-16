# Juntar varios csv en uno 
# Primero nombrar por orden los csv que se quieren unir

$folderCsv = 'PATH\'
$archivosCsv = $folderCsv+'*.csv'
$nombreCsvNuevo = 'Nombre.csv'
$pathCsvNuevo = $folderCsv + $nombreCsvNuevo


Get-Content -Filter *.csv -Path $archivosCsv | Add-Content -path $pathCsvNuevo
