$targetIP = "xxx.xxx.xxx.xxx"

while($true) {
    $response = Test-Connection -ComputerName $targetIP -Count 1 -Quiet

    if (!$response) {
        $message = "{0} - No se recibió respuesta de {1}" -f (Get-Date -f "yyyyMMdd HH:mm:ss"), $targetIP
        Write-Host $message
    }
}
