$usuarios = get-content -Path "PATH.txt"
$passGen = ConvertTo-SecureString "Armada$$2022" -AsPlainText -Force
$passAS = "LocalManager$$1"


foreach($user in $usuarios){
    
    if ($user -match '_as') {
    
        new-localuser "$user" -Password $passAS -AccountNeverExpires -ErrorAction stop
        Write-Host "Usuario " $user " Creado"

        Add-LocalGroupMember -Group "Users" -Member "Administradores"  -ErrorAction Stop

        Write-Host "Usuario " $user "añadido a grupo"

    }else {

        new-localuser "$user" -Password $passGen -AccountNeverExpires -ErrorAction stop
        Write-Host "Usuario " $user " Creado"

        Add-LocalGroupMember -Group "Usuarios" -ErrorAction Stop

        Write-Host "Usuario " $user "añadido a grupo"
    
    }

}