#########################################################################################
#                           INVENTARIO DE SOFTWARE PC                                   #
#########################################################################################
#                                                                                       #
# ESTE SCRIPT CREA UN INVENTARIO DE SOFTWARE DE LOS PC A LOS QUE SE APLIQUE             #
# EXPORTANDO LOS DATOS POR CADA EQUIPO EN FORMATO TXT,                                  #
# ANEXANDO LA INFORMACION RECOGIDA DE CADA PC.                                          # 
#                                                                                       #
#########################################################################################

#########################################################################################
# EN LA VARIABLE $path TIENES QUE ESPECIFICAR LA CARPETA DONDE GUARDARÁ EL txt          #
#########################################################################################
# GUARDAR EL ARCHIVO INVENTARIO_SW.PS1 EN UN DIRECTORIO DONDE TENGAN ACCESO TODOS LOS   #
# PC DE LOS QUE SE QUIERA HACER INVENTARIO.                                             # 
#########################################################################################
# ESTE SCRIPT GENERA UN NOMBRE DE ARCHIVO QUE EMPIEZA POR TU                            #
# HAY QUE MODIFICAR A MANO LOS DC (DCXX) Y LOS TERMINALES DE ADMINISTRADOR (TUADMXX)    #
#########################################################################################


# Nombre del equipo
$computerSystem = Get-WmiObject Win32_ComputerSystem
$nombreSistema = $computerSystem.name

# Lugar donde se va a guardar la información, en $path tienes que añadir tu ruta donde guardar el archivo
# $path = 'C:\Users\nombre\Desktop\'
$path = 'RUTA\'
$export = $path+'TU_'+$nombreSistema+'_SW.txt'

# Recopilar información de instalación del equipo 
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize | Out-File $export  


