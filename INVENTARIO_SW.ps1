#########################################################################################
#                           INVENTARIO DE SOFTWARE PC                                   #
#########################################################################################
#                                                                                       #
#      ESTE SCRIPT CREA UN INVENTARIO DE SOFTWARE DE LOS PC A LOS QUE SE APLIQUE        #
#             EXPORTANDO LOS DATOS POR CADA EQUIPO EN FORMATO TXT                       # 
#                                                                                       #
#########################################################################################
# EN LA VARIABLE $path TIENES QUE ESPECIFICAR LA CARPETA DONDE GUARDARÁ EL txt          #
# EN LA VARIABLE $fileLog TIENES QUE ESPECIFICAR LA RUTA DONDE SE GUARDARÁ EL LOG       #
#########################################################################################
# ESTE SCRIPT GENERA UN NOMBRE DE ARCHIVO QUE EMPIEZA POR TU                            #
# HAY QUE MODIFICAR A MANO LOS DC (DCXX) Y LOS TERMINALES DE ADMINISTRADOR (TUADMXX)    #
#########################################################################################
# DIEGO                                                                                 #   
# Marzo, 2022                                                                           #  
#########################################################################################


# Nombre del equipo
$computerSystem = Get-WmiObject Win32_ComputerSystem
$nombreSistema = $computerSystem.name

# Lugar donde se va a guardar la información, en $path tienes que añadir tu ruta donde guardar el archivo
# $path = 'C:\Users\nombre\Desktop\'
$path = 'PATH\'
$nombreArchivo = 'TU_'+$nombreSistema+'_SW.txt'
$export = $path+$nombreArchivo
$fileLog = 'PATH\log_inv_SW.txt'


# Verifica si existe el archivo log, si no existe lo crea

if (-not(Test-Path -Path $fileLog -PathType Leaf)) {
    try { 
        New-Item -Path $fileLog -ItemType File
        $msglog = "Se genera el archivo LOG en  " + " - " + $fileLog + "`n"
        (Get-Date).ToString() + " - " + $msglog >> $fileLog
           }
    catch {
        throw $_.Exception.Message
    }
   }

# Verifica si existe el archivo del equipo, si existe lo elimina para sustituirlo por uno nuevo, para reflejar los cambios que pueda haber

if (Test-Path -Path $export -PathType Leaf) {
    try { 
        Remove-Item -Path $export

        # Se registra en el log el borrado del archivo
        $msglog = "Borrado Archivo configuracion SW PC: " + " - "+ $nombreArchivo
        (Get-Date).ToString() + " - " + $msglog >> $fileLog

           }
    catch {
        throw $_.Exception.Message
    }
   }

# Recopilar información de instalación del equipo 
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize | Out-File $export  

# Añadir info al log
$msglog = "Generado archivo configuracion SW PC: " + " - " + $nombreSistema
(Get-Date).ToString() + " - " + $msglog >> $fileLog




