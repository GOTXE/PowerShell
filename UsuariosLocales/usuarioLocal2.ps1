$usersCsv = import-csv -Path "PATH.csv" -Delimiter ";" | format-table

foreach($user in $usersCsv){
    
    $empleo = $user.Empleo
    $nombre = $user.Nombre
    $apellido1 = $user.Apellido1
    $apellido2 = $user.Apellido2
    $Nusuario = $user.Nusuario
    $passwd = $user.Passwd
    $MiembroDe1 = $user.Miembrode1
    $MiembroDe2 = $user.Miermbrode2
    $MiembroDe3 = $user.Miembrode3

    
    if ($Nusuario -match '_as') {
    
        new-localuser -Name "$nombre" -Password $SecPass -AccountNeverExpires -ErrorAction stop
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