## Como eliminar @{} de salida de datos
# En primer ejemplo aparece @{}

$computer = Get-WMIObject Win32_OperatingSystem |select-object caption

Write-Host $computer

$computer = Get-WMIObject Win32_OperatingSystem |select-object -ExpandProperty caption -First 1

Write-Host $computer