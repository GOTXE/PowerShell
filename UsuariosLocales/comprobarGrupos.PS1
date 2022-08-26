
$csv = Import-Csv -Path 'PATH.csv' -Delimiter ';' |sort group1,group2

# Crear array para los grupos
$grupos = @()

# Añadir los grupos al array
$grupos+=$csv.Grupo1
$grupos+=$csv.Grupo2

# Filtrar los elementos vacíos del array (csv)
$grupos.Where({ $_ -ne ""})

# Filtrar elementos únicos
$gruposUnicos = $grupos | sort -Unique
$gruposUnicos


# Grupos del sistema
$gruposSystem = @()
$gruposSystem+= (Get-LocalGroup).Name


# Compara grupos sistema con grupos csv

foreach($group in $gruposUnicos){
    if (!($group -in $gruposSystem)){
        Write-Host 'El grupo ' $group ' NO EXISTE'
    }

}

