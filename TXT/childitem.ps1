# Listar archivos de una carpeta y generar un txt

get-childitem -Path 'PATH' | Select-Object Name,LastWriteTime | Sort-Object -Descending | Format-Table -AutoSize -HideTableHeaders | Out-File -FilePath "path.txt"

(Get-Content "path.txt") | Where-Object {$_.trim() -ne ""} | Set-Content "mismo_path.txt"  # Elimina la línea en blanco que se crea en el txt