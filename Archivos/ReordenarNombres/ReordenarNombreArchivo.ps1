$path = "PATH"


Get-ChildItem -path $path| where {$_.Name -match 'UF+ '} | ForEach-Object{

    Rename-Item -Path $_.FullName -NewName ($_.Name -replace ('UF+ ','UF')) -ErrorAction SilentlyContinue # Cambia UF\sXXXX  por UFXXXX

} 

Get-ChildItem -path $path | where {$_.Name -match "Prueba[a-z,' ',-]Pr[\w]ctica" -or "Pr[\w]ctica"} | ForEach-Object {

    Rename-Item -Path $_.FullName -NewName ($_.Name -replace ("Prueba[a-z,' ',-]Pr[\w]ctica","")) -ErrorAction SilentlyContinue # Cambia Prueba Practica por nada
    Rename-Item -Path $_.FullName -NewName ($_.Name -replace ("Pr[\w]ctica","")) -ErrorAction SilentlyContinue # Cambia Practica por nada

   }

Get-ChildItem -Path $path | where {$_.Name -match "\.{2,}"} | ForEach-Object {

    Rename-Item -Path $_.FullName -NewName ($_.Name -replace ("\.{2,}",".")) -ErrorAction SilentlyContinue # Cambia .. por .

} 

Get-ChildItem -Path $path | where {$_.Name -match "MF0080-2-??"} | ForEach-Object {

    Rename-Item -Path $_.FullName -NewName ($_.Name -replace("MF0080-2-?",""))  # Elimina MF0080-2- 
         
}

Get-ChildItem -Path $path | ForEach-Object {

   Rename-Item -Path $_.FullName -NewName ($_.Name.Trim()) # Elimina los espacios iniciales
}


Get-ChildItem -path $path| where {$_.Name -match "\w\d{4}\w??\s{2}"} | ForEach-Object{

    Rename-Item -Path $_.FullName -NewName ($_.Name -replace ("  "," - ")) -ErrorAction SilentlyContinue # Corrige 2 espacios a \s-\s despues de UFXXX - .....

} 

Get-ChildItem -path $path| where {$_.Name -notmatch "\w\d{4}\w??\s-"} | ForEach-Object{
    
     $cuenta = $_.Name.IndexOf(' ')

     Rename-Item -Path $_.FullName -NewName ($_.Name.Remove($cuenta,1).Insert($cuenta," - ")) -ErrorAction SilentlyContinue # Cambia el nombre UFXXX L... y UFXXXXD M... a \s-\s

}

