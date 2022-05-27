# Comprobar los permisos de ejecucion de PS

Get-ExecutionPolicy -List

# Establecer permisos para el usuario
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Estabalecer permisos para la maquina local
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine

# Omita la sesión actual de PowerShell, una vez que cierre esta sesión de PowerShell, esta configuración se perderá
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass