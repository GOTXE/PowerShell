function DisplayMenu {
    Clear-Host
    Write-Host @"
    +=========================+
    |        MENU PING        | 
    +=========================+
    |                         |
    |   1) PING SWITCHES      |
    |   2) PING SERVIDORES    |
    |   3) PING ------        |
    |   4) PING xx.xx.xx.xx   |
    |   5) SALIR              |
    +=========================+
    
"@

    $path = "C:\temp"
    
    $MENU = Read-Host "OPTION"
    Switch ($MENU)
    {
    1 {
        #OPCION 1 - PING SWITCHES
        $iplista = get-content $path\listaSwitches.txt
        
            foreach ($ip in $iplista) {  
                $resultado = Test-Connection $ip -count 1 -Quiet -ErrorAction Continue
                 Write-Host $ip $resultado
                 }

        Start-Sleep -Seconds 2
        DisplayMenu
    }
    2 {
        #OPCION 2 - PING SERVIDORES
        $iplista = get-content $path\listaServidores.txt

        foreach ($ip in $iplista) {  
                $resultado = Test-Connection $ip -count 1 -Quiet -ErrorAction Continue
                 Write-Host $ip $resultado
                 }
        Start-Sleep -Seconds 2
        DisplayMenu
    }
    3 {
        #OPCION 3 - PING Todos
        $iplista = get-content $path\listaTotal.csv
        
            foreach ($ip in $iplista) {  
                 $resultado = Test-Connection $ip -count 1 -Quiet -ErrorAction Continue
                 Write-Host $ip $resultado
             }
        Start-Sleep -Seconds 2
        DisplayMenu
    }
    4{
        #OPCION 4 - PING IP ESPECIFICADA
        $IP = Read-Host "IP"
        Test-Connection $IP -ErrorAction Continue -Count 1
        Start-Sleep -Seconds 2
        DisplayMenu
    }
    5{
        #OPCION 5 - SALIR
        Write-Host "Chau..."
        Break
    }
    default {
        #OPCION DEFAULT
        Write-Host "No has seleccionado nada..."
        Start-Sleep -Seconds 2
        DisplayMenu
    }
    }
}

    DisplayMenu