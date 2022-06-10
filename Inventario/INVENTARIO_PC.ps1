#########################################################################################
#                              INVENTARIO  PC                                           #         
#########################################################################################
#                                                                                       #
# ESTE SCRIPT CREA UN INVENTARIO DE LOS PC A LOS QUE SE APLIQUE, EXPORTANDO LOS DATOS   #
# POR EQUIPO EN FORMATO TXE. ANEXANDO LA INFORMACION RECOGIDA DE CADA PC.               #
#                                                                                       #
#########################################################################################
# TIENES QUE INTRODUCIR LA RUTA DONDE SE GUARDAR¡ EL ARCHIVO                            #
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

# Introducir ruta y nombre donde guardar el archivo

# Nombre del equipo
$computerSystem = Get-WmiObject Win32_ComputerSystem
$nombreSistema = $computerSystem.name

# INTRODUCIR RUTA DONDE GUARDAR EL ARCHIVO
$path = 'PATH\'

# Lugar donde se guarda el archivo con nombre del equipo
$nombreArchivo = 'SRV_'+$nombreSistema+'.txt' # CAMBIAR 'SRV_' por las siglas que quieras para identificar PC's diferentes
$export = $path+$nombreArchivo


# TITULOS
$tituloEQ = 'EQUIPO: ' + $nombreSistema
$tituloHW = "INVENTARIO HARDWARE"
$tituloDD = "DISCOS DUROS"
$tituloSW = "INVENTARIO SOFTWARE"

# Verifica si existe el archivo, si no existe lo crea
if (-not(Test-Path -Path $export -PathType Leaf)) {
     try {
         $null = New-Item -ItemType File -Path $export -Force -ErrorAction Stop
        
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
$computerNET = Get-WmiObject win32_networkadapterconfiguration -Filter IPEnabled=TRUE 
$Monitor = Get-WmiObject WmiMonitorID -Namespace root\wmi


# Crea ARCHIVO con los datos recogidos

$csvObject = New-Object PSObject -property @{
'Equipo' = $computerSystem.Name
'Marca' = $computerSystem.Manufacturer
'Modelo' = $computerSystem.Model
'OS' = $computerOS
'CPU' = $computerCPU.Name
'RAM' = "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1GB)
'NumSerie' = $computerBIOS.SerialNumber
'BIOS' = $computerBIOS.SMBIOSBIOSVersion
'MAC' = $computerNET.macadress
'IP' = $computerNET.ipaddress
'Monitor_Marca' = Decode $Monitor.ManufacturerName -notmatch 0
'Monitor_Nombre' = Decode $Monitor.UserFriendlyName -notmatch 0
'Monitor_Serial' = Decode $Monitor.SerialNumberID -notmatch 0

 }



# Exporta campos al archivo
Add-Content $export $tituloEQ

$csvObject |Select-Object Equipo, Marca, Modelo, OS, CPU, RAM, NumSerie, BIOS, MAC, IP, Monitor_Marca, Monitor_Nombre, Monitor_Serial | format-List  | Out-File $export -Append utf8

######################################################
# SCRIPT PARA CONSULTAR DATOS DE VARIOS DISCOS DUROS #
######################################################

Add-Content $export "$tituloDD `n"

$maxLineLength  = 79  # counted from the longest line in your example
$maxValueLength = 0   # a counter to keep track of the largest value length in characters

$info_diskdrive_basic = Get-WmiObject Win32_DiskDrive | ForEach-Object {
    $disk = $_
    $partitions = "ASSOCIATORS OF " + "{Win32_DiskDrive.DeviceID='$($disk.DeviceID)'} " + "WHERE AssocClass = Win32_DiskDriveToDiskPartition"
    Get-WmiObject -Query $partitions | ForEach-Object {
        $partition = $_
        $drives = "ASSOCIATORS OF " + "{Win32_DiskPartition.DeviceID='$($partition.DeviceID)'} " + "WHERE AssocClass = Win32_LogicalDiskToPartition"
        Get-WmiObject -Query $drives | ForEach-Object {
            $obj = [PSCustomObject]@{
                'Disk'         = $disk.DeviceID
                'Disk Model'   = $disk.Model
                'Partition'    = $partition.Name
                'Raw Size'     = '{0:d} GB' -f [int]($partition.Size/1GB)
                'Drive Letter' = $_.DeviceID
                'Volume Name'  = $_.VolumeName
                'Size'         = '{0:d} GB' -f [int]($_.Size/1GB)
                'Free Space'   = '{0:d} GB' -f [int]($_.FreeSpace/1GB)
            }
            # get the maximum length for all values
            $len = ($obj.PsObject.Properties.Value.ToString().Trim() | Measure-Object -Property Length -Maximum).Maximum
            $maxValueLength = [Math]::Max($maxValueLength, $len)
                                          
            # output the object to be collected in $info_diskdrive_basic
            $obj
        }
    }
}

# sort the returned array of objects on the DriveLetter property and loop through
$result = $info_diskdrive_basic | Sort-Object DriveLetter | ForEach-Object {
    # loop through all the properties and calculate the padding needed for the output
    $_.PsObject.Properties | ForEach-Object {
        $label   = '# {0}:' -f $_.Name.Trim()
        $padding = $maxLineLength - $maxValueLength - $label.Length
        # output a formatted line
        "{0}{1,-$padding}{2}" -f $label, '', $_.Value.ToString().Trim()
    }
    # add a separator line between the disks
    ''
}


# Escribir datos en disco
$result | format-table -AutoSize | Out-File $export -Append utf8


#######################
# INVENTARIO SOFTWARE #
#######################

Add-Content $export "`n$tituloSW"

Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize | Out-File $export -Append utf8
