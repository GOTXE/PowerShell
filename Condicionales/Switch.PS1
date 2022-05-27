# SWITCH 

$color = Read-Host "Introduce un color (Rojo, Amarillo o Verde):"
switch ($color) {
    'Rojo' { Write-Host "Detente!" 
        break
        }           
    'Amarillo' {Write-Host "Precaución"
        break
        }
    'Verde' {Write-Host "Pasa"
        break
        }
    Default {Write-Host "Eso no es un color"}
}

Write-Host "Fin de programa"