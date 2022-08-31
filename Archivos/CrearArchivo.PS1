# Crear Archivo, verificar si existe antes de crearlo
# Script estraido de https://adamtheautomator.com/powershell-check-if-file-exists/

# Path al archivo
$file = 'Path\texto.txt'

# Si el archivo no existe lo crea
if (-not(Test-Path -Path $file -PathType Leaf)) {
     try {
         $null = New-Item -ItemType File -Path $file -Force -ErrorAction Stop
         Write-Host "The file [$file] has been created."
     }
     catch {
         throw $_.Exception.Message
     }
 }
# Si el archivo existe, lo muestra en mensaje pero no hace nada
 else {
     Write-Host "Cannot create [$file] because a file with that name already exists."
 }
