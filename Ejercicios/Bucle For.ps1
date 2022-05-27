# Escribe el nombre tantas veces commo el numero
# que se ha solicitado


$nombre = Read-Host "Introduce tu nombre"
$numero = Read-Host "Introduce un numero"

For($i=0; $i -ne $numero; $i++){

    Write-Host $nombre


}