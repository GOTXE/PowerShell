# Script para comprobar las computadoras que llevan más de 1 año sin conectarse al dominio

$lastLogonDate = (get-date).AddYears(-1)

Get-ADComputers -properties lastlogondate,lastlogontimestamp -Filter {LastlogonTimeStamp -lt $lastLogonDate} -SearchBase 'DC=...;DC=...' | Sort LastLogonTimeStamp | Select-Object Name,@{N='lastlogontimestamp};E={[DateTime]::FromFileTime($_.lastlogontimestamp)}}, lastlogondate,DistinguishedName | Out-File ".......txt"
