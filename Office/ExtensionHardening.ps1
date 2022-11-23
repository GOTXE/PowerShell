# Modificar clave de registro de usuario de excel para evitar la ventana de error extensión archivo

$RegistryPath = 'HKCU:\SOFTWARE\Microsoft\Office\15.0\Excel\Security'
$Name = 'ExtensionHardening'
$Value = '0'

If (!(Test-Path $RegistryPath))
{

New-Item $RegistryPath -force
}

Set-ItemProperty $RegistryPath -Name $Name -Value $Value -Type DWORD -Force
