# Script para buscar de forma rápida si está instalado el HOTFIX que se especifique o buscar todos los hotfix

function showmenu {

    Clear-Host
    Write-Host "Menú ..."
    Write-Host "1. Buscar todas las HotFix"
    Write-Host "2. Buscar HotFix específica"
    Write-Host "3. Salir"

}

showmenu

while (($ent = Read-Host -Prompt "Selecciona una opción: ") -ne '3'){

    switch ($ent){

        1 {
            Clear-Host
            wmic qfe list
            pause;
            break
            }

        2{
            Clear-Host

            $largoID = '0'

            while ($largoID -ne '9'){

                $HotfixID = Read-Host Introduce el numero de HOTFIX KBxxxx 
     
                $largoID = $HotfixID.Length
            }

            Write-Host "Buscando ..."

            $searchKB = Get-HotFix -id $HotfixID -errorAction silentlyContinue


            if(!($searchKB)){

                Write-Host "El HotFix $HotfixID No está instalado!!"
            } else {

                $searchKB 
            }
                    pause;
                    break
                    }

        3 {
            "Salir";
            break
        
        }

        default {Write-Host -ForegroundColor red -BackgroundColor white "Opción No Válida!!. Por favor seleccione otra opción.";pause}
        
        }

    showmenu
}