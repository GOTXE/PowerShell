# Escribe el nombre tantas veces commo el numero
# que se ha solicitado


$nombre = Read-Host "Introduce tu nombre"
$numero = Read-Host "Introduce un número"
$reps = 0

    while ($reps -ne $numero) {
        
        Write-Host $nombre
        $reps++
    
    }