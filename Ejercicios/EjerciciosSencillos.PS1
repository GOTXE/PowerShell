# 1- Preguntar nombre y mostrar Hola! <nombre>

$nombre = Read-Host "Escribe tu nombre"
Write-Host "Hola, $nombre!"

# 2- Preguntar nombre, preguntar número, escribir nombre tantas veces como número

$nombre = Read-Host "Escribe tu nombre"
$numero = Read-Host "Escribe un numero"
$num = 0

while ($num -ne $numero) {

    Write-Host $nombre
    $num++
    
}

# Otra solucion con For

$nombre = Read-Host "Escribe tu nombre"
$numero = Read-Host "Escribe un numero"

For ($i=0;$i -ne $numero;$i++){

    Write-Host $nombre
}
# 3- Solicita nombre, muestra en consola <NOMBRE> y número de letras

$nombre = Read-Host "Escribe tu nombre"

Write-Host $nombre.ToUpper() "tiene " $nombre.Length " letras"

# 4- Realizar el cálculo (3+2 / 2*5)^2

$calculo = [math]::pow(((3+2)/(2*5)),2)
Write-Host $calculo

# 5- Pregunta horas trabajadas, precio hora y calcula ingreso

[int]$horas = Read-Host "¿Cúantas horas trabajaste"
[int]$pHora = Read-Host "¿Cúanto vale cada hora?"

$resultado = $horas*$pHora
Write-Host "Se te pagarán $resultado € por las $pHora trabajadas"

# 6- Solicitado un numero, n, sumar desde 1 hasta n

[int]$num = Read-Host "Introduce un número positivo"
$resultado = (($num*($num+1))/2)
Write-Host "El resultado de sumar desde 1 hasta $num es $resultado"

# Resolucion con For
[int]$num = Read-Host "Introduce un número positivo"
$resultado = 0

for ($i = 1; $i -le $num; $i++){
    $resultado = $resultado+$i
}

Write-Host $resultado


# 7- Pedir altura en metros, peso en kg, calcular IMC 
[float]$altura = Read-Host "Escribe tu altura en metros"
[float]$peso = Read-Host "Escribe tu peso en kg"

[float]$resultado = ($peso/([math]::pow($altura,2)))
$resultado = [Math]::Round($resultado,2)

Write-Host "Tu IMC es de $resultado, ajustado a dos decimales "

# 8 - Pedir 2 numeros enteros. Mostrar n entre m da cociente c, y resto r.

$n1 = Read-Host "Introduce un número"
$n2 = Read-Host "Introduce otro número"

$cociente = $n1/$n2

$resto = $n1%$n2

Write-Host "El cociente de $n1 entre $n2 es $cociente"
Write-Host "El resto de la division de $n1 entre $n2 es $resto"


# 9 - Pedir cantidad de dinero a invertir, interes anual y número de años. 
#     Devolver resultado obtenido de la inversión

[float]$aporteDinero = Read-Host "¿Cúanto vas a invertir?"
[float]$interesAnual = Read-Host "¿Cuánto es el interés anual?"
[float]$años = Read-Host "¿Cúantos años tendrás la inversión?"

$interesGanado = $aporteDinero*($interesAnual/100)

$capitalObtenido = $interesGanado*$años

Write-Host "El capital final es $capitalObtenido"