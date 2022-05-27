# Hacer ping a un equipo concreto

Test-NetConnection google.com

# Que solo muestre si hay ping 

Test-NetConnection google.com -InformationLevel Quiet

# Por nombre de equipo

Test-NetConnection -ComputerName nombreEquipo

# Hacer ping a varios equipos desde un listado

Test-Connection -ComputerName (Get-Content 'C:\temp\Servers_list.txt') -ErrorAction SilentlyContinue -Count 1 | Out-GridView


##

$pingOutput= @()
$pingnames = Get-Content "C:\temp\Servers_list.txt"
foreach ($name in $pingnames){
  if (Test-Connection -ComputerName $name -Count 1 -ErrorAction SilentlyContinue){
   $pingOutput+= "$name,Up"
   Write-Host "$Name,Up"
  }
  else{
    $pingOutput+= "$name,Down"
    Write-Host "$Name,Down"
  }
}
$pingOutput | Out-GridView