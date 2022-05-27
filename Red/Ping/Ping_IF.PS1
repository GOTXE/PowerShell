#Resolve-DnsName 8.8.8.8 |Select-Object name,namehost

$path = "C:\temp"
$listaServidores = get-content $path'\listaServidores.txt'

Write-Host $listaServidores

foreach ($ip in $listaServidores){


$ping = Test-Connection $ip -ErrorAction SilentlyContinue -Count 1 |Select-Object -Property IPV4Address,ResponseTime

if ($ping.ResponseTime -ge "0"){
    
    $nombre = Resolve-DnsName $ip |Select-Object namehost

    write-host $ip "= Activa >> " $ping.responsetime "ms" " " $nombre.namehost


}else {write-host $ip "= No responde al ping" -ForegroundColor Red}
 
}