$recDatos = Get-WinEvent @{LogName='Security';ProviderName='Microsoft-Windows-Security-Auditing';ID=4625 } |Select-Object timeCreated, Message |Format-List -Property *  # -ComputerName $server

$recDatos | Out-File -FilePath "Path\recData.txt" -Encoding utf8