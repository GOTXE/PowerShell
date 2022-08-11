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

# Extensiones archivo
$extXcl = ".xlsx"
$extCsv = ".csv"

# INTRODUCIR RUTA DONDE GUARDAR EL ARCHIVO
$path = 'Path\'

# Lugar donde se guarda el archivo con nombre del equipo
$nombreArchivo = 'TU_'+$nombreSistema+'.txt' # CAMBIAR 'TU_' por las siglas que quieras para identificar PC's diferentes
$export = $path+$nombreArchivo

# Nombre archivo software CSV
$archivoSW = 'TU_'+$nombreSistema+'_SW'+$extCsv
$exportSW = $path+$archivoSW

# Nombre archivo software XLSX
$csv = $exportSW
$xlsx = $path+'TU_'+$nombreSistema+'_SW'+$extXcl

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

if (-not(Test-Path -Path $exportSW -PathType Leaf)) {
     try {
         $null = New-Item -ItemType File -Path $exportSW -Force -ErrorAction Stop
        
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
'MAC' = $computerNET.macadress
'IP' = $computerNET.ipaddress
'Monitor_Marca' = Decode $Monitor.ManufacturerName -notmatch 0
'Monitor_Nombre' = Decode $Monitor.UserFriendlyName -notmatch 0
'Monitor_Serial' = Decode $Monitor.SerialNumberID -notmatch 0
'Product_Type' = $computerInfo.OsProductType
'Windows_Product_Name' = $computerInfo.WindowsProductName
'Os_Architecture' = $computerInfo.OsArchitecture
'OS_Version' = $computerInfo.OsVersion
'Os_Build' = $computerInfo.OsBuildNumber
'Bios_Fecha' = $computerInfo.BiosReleaseDate

 }



# Exporta campos al archivo
Add-Content $export $tituloEQ

$csvObject |Select-Object Equipo, Marca, Modelo,Product_Type,Windows_Product_Name, OS,Os_Architecture,OS_Version,Os_Build, CPU, RAM, NumSerie, BIOS,Bios_Fecha, MAC, IP, Monitor_Marca, Monitor_Nombre, Monitor_Serial | Out-File -FilePath $export -Append -Encoding ascii -Force


Start-Sleep -Seconds 5


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

Start-Sleep -Seconds 5

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
$result | format-table -AutoSize | Out-File -FilePath $export -Append -Encoding ascii -Force


#######################
# INVENTARIO SOFTWARE #
#######################

Start-Sleep -Seconds 5

function Get-InstalledApps
{
   $regpath = @(
            'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
            'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
        )
     Get-ItemProperty $regpath | .{process{if($_.DisplayName -and $_.UninstallString) { $_ } }} | Select-Object DisplayName, Publisher, DisplayVersion |Sort-Object Publisher
}

Get-InstalledApps | Export-Csv -NoTypeInformation -Path $exportSW -Append -Force

Start-Sleep -Seconds 5


# Exportar csv a excel formateado
# Definir delimitador
$delimiter = ","

# Crear excel nuevo con hoja vacía
$excel = new-object -ComObject excel.application
$workbook = $excel.workbooks.add(1)
$worksheet = $workbook.worksheets.item(1)

# Construir las tablas de query y reformaterar datos
$TxtConnector = ("TEXT;" + $csv)
$Connector = $worksheet.QueryTables.add($TxtConnector,$worksheet.Range("A1"))
$query = $worksheet.QueryTables.item($Connector.name)
$query.TextFileOtherDelimiter = $delimiter
$query.TextFileParseType = 1
$query.TextFileColumnDataTypes = ,1 * $worksheet.Cells.Columns.Count
$query.AdjustColumnWidth = 1

# Ejecutar y eliminarl la query de importaicion
$query.Refresh()
$query.Delete()

# Guardar y salir del libro de XLSX
$Workbook.SaveAs($xlsx,51)
$excel.Quit()

# Eliminar archivo csv
Remove-Item -Path $exportSW -Force


