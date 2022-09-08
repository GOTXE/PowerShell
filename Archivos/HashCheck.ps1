##################################
#   Comprobar hash del archivo   #
#                                #
#  +Escibir la Ruta a la carpeta #
##################################


Clear-Host

# Introducir la ruta a la carpeta donde está el archivo, tiene que estar ese archivo único
$path = 'Path\'

# Solicita el valor del hash al usuario para poder compararlo
$hashweb = Read-Host "introduce el hash 256 del archvivo "
Trim($hashweb)

# Recoge el dato hash del archivo 
$archivo = Get-ChildItem -Path $path |Select-Object name
$hashArchivo = Get-FileHash ($path + $archivo.Name)

# Muestra en pantalla los valores del hash introducido y del archivo
Write-Host "Hash Archivo descargado: " $hashArchivo.Hash
Write-Host "Hash introducido:        " $hashweb

# Compara los valores
if ($hashArchivo.Hash -eq $hashweb) {
    Write-Host "Los archivos son iguales!"
}else {
    Write-Host "OJO !! REVISA!! EL HASH NO ES IGUAL!!"
    Write-Host "El hash del introducido es: " $hash.Hash
    Write-Host "El hash del Archivo es    : " $hashArchivo.Hash
}