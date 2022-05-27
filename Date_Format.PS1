# Info sacada de https://www.delftstack.com/howto/powershell/format-a-datetime-in-powershell/

# Fomartear salida de fechas

# Fecha completa
Get-date

# Solo fecha y hora
Get-date -format "dd-MM-yyy HH:mm:ss"

# Solo fecha
Get-date -format "dd-MM-yyy"


# Se pueden cambiar los guiones - por /

Get-date -format "dd/MM/yyy"

# Muestra todas las salidas formateadas para get-date, creando un array
(Get-date).Getdatetimeformats() 

# se puede seleccionar la posición dentro del array para mostrar solo esa salida
(Get-date).Getdatetimeformats()[155]

# Saber longitud del array
$fechasArray=(Get-date).Getdatetimeformats()
$longitudArray=$fechasArray.length
Write-Host $longitudArray