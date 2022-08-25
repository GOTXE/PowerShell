$csv = Import-Csv -Path 'C:\Users\diego\Documents\usuarios.csv' -Delimiter ';'

$users = foreach($user in $csv){

    $nombre = $user.Nombre
    $grupo1 = $user.Grupo1
    $grupo2 = $user.Grupo2


    if ($grupo2 -eq 'null'){
        write-host $nombre '::' $grupo1
    
    }else {
        write-host $nombre '::' $grupo1 $grupo2
    }

}