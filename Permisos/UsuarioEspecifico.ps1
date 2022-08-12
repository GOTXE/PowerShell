# Ejecutar powershell con un usuario especifico

# https://davidhamann.de/2019/12/08/running-command-different-user-powershell/

powershell.exe -c "$user='WORKGROUP\John'; $pass='password123'; 

try { Invoke-Command -ScriptBlock { Get-Content C:\Users\John\Desktop\secret.txt } -ComputerName Server123 -Credential (New-Object System.Management.Automation.PSCredential $user,(ConvertTo-SecureString $pass -AsPlainText -Force)) 
} catch { echo $_.Exception.Message }" 2>&1



# Otros métodos
https://blog.atwork.at/post/Run-PowerShell-script-as-different-user

# Pidiendo usuario por ventana
$cred = Get-Credential -UserName 'DOMAIN\USERNAME' -Message ' '

