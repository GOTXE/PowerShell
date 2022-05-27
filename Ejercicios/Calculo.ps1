# Solicitar horas trabajadas y precio hora. Mostrar pago

[int]$horas = Read-Host "¿Cuantas horas trabajaste?"
[int]$pHora = Read-Host "¿Cuanto vale cada hora?"

$pago = $horas*$pHora

Write-Host "Se te pagarán " $pago "€ por las " $horas " trabajadas."