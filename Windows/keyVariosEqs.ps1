# Script para sacar el Serial de windows y añadirlo a un archivo con el número de serie y la versión de windows

#Buscar el Pen Drive y extraer la letra donde se guardarán los datos
$UsbDrive = Get-WmiObject Win32_Volume -Filter 'DriveType=2' |Select-Object -ExpandProperty driveletter

$path = $UsbDrive + '\WinSerials.txt'

# Comprobar que el archivo existe o crearlo
if(-not(test-path -path $path -pathtype Leaf) ) {

 $null = New-Item -ItemType File -Path $path -Force -ErrorAction Stop

        if(-not (test-path -path $path)) {
             Write-Host "No se ha podido crear el archivo en el Disco"
             } else {Write-Host "Archivo Creado"}

} else {Write-Host "El archivo ya existe!, añadiendo datos..."}

# Crear un objeto con los datos a añadir al archivo
$objeto = New-Object PSObject -Property @{
'OSVersion' = (ComputerInfo).OsVersion
'Equipo Serial' =  (Get-WmiObject Win32_BIOS).SerialNumber 
'Windows Key' = (Get-WmiObject -query ‘select * from SoftwareLicensingService’).OA3xOriginalProductKey
}

$objeto |Out-File -FilePath $path -Append 

Write-Host "Finalizado!!"
