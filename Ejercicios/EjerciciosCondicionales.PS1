# EJERCICIOS CONDICIONALES #

# 1- PEDIR EDAD, MOSTRAR SI ES O NO ES MAYOR DE EDAD

[int]$edad = Read-Host "Introduce tu edad"

if ($edad -ge 18) {
    Write-Host "Eres mayor de edad"
} else {
    Write-Host "Eres menor de edad"
}

# 2- INtroducir una contraseña. Pedir la contraseña, mostrar si error o no

$passwd1 = Read-Host "Introduce una contraseña"
$passwd2 = Read-Host "Repite la contraseña"

if ($passwd2 -eq $passwd1) {
    Write-Host "Las contraseñas son iguales"
} else {
    Write-Host "Las contraseñas no coinciden"
}


# Resolución con While    REVISAR

$passwd1 = Read-Host "Introduce una contraseña"
$passwd2 = Read-Host "Repite la contraseña"

while ($passwd2 -ne $passwd1) {
    Write-Host "Las contraseñas no coinciden"
    $passwd2 = "Introduce la contraseña"
}

Write-Host "Las contraseñas coinciden"