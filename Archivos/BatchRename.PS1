# Script para añadir un cambio de nombre de archivos

# Establece el path a los archivos
$path = $env:userprofile + '\desktop\folder'
# Texto a añadir
$nombreNuevo = "Lo que quieras poner - "

# Recoje nombres de los archivos pdf y los renombra
Get-childItem -Path $path *.pdf | ForEach-Object{
    Rename-Item -Path $_.FullName -NewName ($nombreNuevo + $_.Name)
}