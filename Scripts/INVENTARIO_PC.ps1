#########################################################################################
#                              INVENTARIO HARDWARE PC                                   #         
#########################################################################################
#                                                                                       #
# ESTE SCRIPT CREA UN INVENTARIO DE LOS PC A LOS QUE SE APLIQUE, EXPORTANDO LOS DATOS   #
# POR EQUIPO EN FORMATO CSV. ANEXANDO LA INFORMACION RECOGIDA DE CADA PC.               #
#                                                                                       # 
# EN CASO DE TENER VARIOS DISCOS DUROS NO SE CALCULA EL TAMAÑO DE DISCO (HDD_GB)        #
#                                                                                       #
#########################################################################################
# PRIMERO INTRODUCIR LA RUTA DONDE SE GUARDARÁ EL ARCHIVO INVENTARIO.CSV                #
# EN LA VARIABLE $export                                                                #
#########################################################################################
# GUARDAR EL ARCHIVO INVENTARIO_PC.PS1 EN UN DIRECTORIO DONDE TENGAN ACCESO TODOS LOS   #
# PC DE LOS QUE SE QUIERA HACER INVENTARIO.                                             # 
#########################################################################################


# Funcion para traducir valores
function Decode {
    If ($args[0] -is [System.Array]) {
        [System.Text.Encoding]::ASCII.GetString($args[0])
    }
    Else {
        "Not Found"
    }
}

# Introducir ruta y nombre donde guardar el archivo CSV
$path = 'PATH\'
$nombreArchivo = 'inventario.csv'

# Path más archivo csv
$export = $path + $nombreArchivo


# Verifica si existe el archivo, si no existe lo crea
if (-not(Test-Path -Path $export -PathType Leaf)) {
     try {
         $null = New-Item -ItemType File -Path $export -Force -ErrorAction Stop
         Write-Host "The file [$export] has been created."
     }
     catch {
         throw $_.Exception.Message
     }
    }

# Recoger informacion del PC

$computerSystem = Get-WmiObject Win32_ComputerSystem
$computerBIOS = Get-WmiObject Win32_BIOS
$computerOS = Get-WmiObject Win32_OperatingSystem |select-object -expandproperty caption -First 1
$computerCPU = Get-WmiObject Win32_Processor
$computerDiskDrive = Get-WMIObject win32_diskdrive
$computerNET = Get-WmiObject win32_networkadapterconfiguration -Filter IPEnabled=TRUE | select-object -ExpandProperty macaddress -First 1
$Monitor = Get-WmiObject WmiMonitorID -Namespace root\wmi


# Crea CSV con los datos recogidos

$csvObject = New-Object PSObject -property @{
'Equipo' = $computerSystem.Name
'Marca' = $computerSystem.Manufacturer
'Modelo' = $computerSystem.Model
'OS' = $computerOS
'CPU' = $computerCPU.Name
'RAM' = "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB)
'HDD_GB' = '{0:d} GB' -f [int]($computerDiskDrive.Size/1GB)
'HDD_MARCA' = $computerDiskDrive.Model
'HDD_SERIAL' = $computerDiskDrive.SerialNumber
'NumSerie' = $computerBIOS.SerialNumber
'BIOS' = $computerBIOS.SMBIOSBIOSVersion
'Eth' = $computerNET
'Monitor_Marca' = Decode $Monitor.ManufacturerName -notmatch 0
'Monitor_Nombre' = Decode $Monitor.UserFriendlyName -notmatch 0
'Monitor_Serial' = Decode $Monitor.SerialNumberID -notmatch 0

 }

# Exporta campos al csv

$csvObject | Select-Object Equipo, Marca, Modelo, OS, CPU, RAM, NumSerie, BIOS, Eth, HDD_GB, HDD_MARCA, HDD_SERIAL, Monitor_Marca, Monitor_Nombre, Monitor_Serial | Export-Csv $export -NoTypeInformation -Append

# Fin