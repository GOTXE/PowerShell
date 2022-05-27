function DisplayMenu {
    Clear-Host
    Write-Host @"
    +=========================+
    |        MENU PING        | 
    +=========================+
    |                         |
    |   1) PING SWITCHES      |
    |   2) PING SERVIDORES    |
    |   3) PING MADRID        |
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
    $listaSwitches = get-content $path'\listaSwitches.txt'
    Test-Connection -ComputerName $listaSwitches -ErrorAction Continue -Count 1 | Out-GridView
    Start-Sleep -Seconds 2
    DisplayMenu
    }
    2 {
    #OPCION 2 - PING SERVIDORES
    $listaServidores = get-content $path'\listaServidores.txt'
    Test-Connection -ComputerName $listaServidores -ErrorAction Continue -Count 1 | Out-GridView
    Start-Sleep -Seconds 2
    DisplayMenu
    }
    3 {
    #OPCION 3 - PING MADRID
    $listaMadrid = get-content $path'\listaMadrid.txt'
    Test-Connection -ComputerName $listaMadrid -ErrorAction Continue -Count 1 | Out-GridView
    Start-Sleep -Seconds 2
    DisplayMenu
    }
    4{
    #OPCION 4 - PING IP ESPECIFICADA
    $IP = Read-Host "IP"
    Test-Connection -ComputerName $IP -ErrorAction Continue -Count 1 | Out-GridView
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