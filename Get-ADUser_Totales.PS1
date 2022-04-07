#######################################################
# Script para generar listado de usuarios en AD       #
# indicar la ruta en la variable $path                #
#######################################################

# Ruta al archivo, escribe la ruta donde se guarda el archivo
$path = 'PATH\'

# Nombre archivo
$nombreArchivo = 'listadoUsuariosAD.csv'

# Path más archivo csv
$export = $path + $nombreArchivo

Write-Host $export

# Extraer información de los usuarios que hay en AD
Get-ADUser -Filter * | Where-Object {$_.enabled -eq "True"} | Select-Object DistinguishedName,GivenName,Surname,UserPrincipalName | Export-Csv -Path $export -NoTypeInformation

## FIN ##