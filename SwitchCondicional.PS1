# SWITCH CON CONDICIONAL

[int] $nota = Read-Host "Introduce tu nota"
switch ($nota) {
    {$_ -gt 8} {
        Write-Host "Sobresaliente"
        break
    }
    {$_ -ge 7} {
        Write-Host "Notable"
        break
    }
    {$_ -ge 6} {
        Write-Host "Bien"
        break
    }
    {$_ -ge 5} {
        Write-Host "Suficiente"
    }
    Default {
        Write-Host "Insuficiente"
    }
}

Write-Host "Fin del programa"