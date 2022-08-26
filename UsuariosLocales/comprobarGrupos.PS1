# Importar campos del csv
$csv = Import-Csv -Path 'PATH.csv' -Delimiter ';' |Sort-Object "Grupo1,Grupo2"

# Crear array para los grupos
$grupos = @()

# Añadir los grupos al array
$grupos+=$csv.Grupo1
$grupos+=$csv.Grupo2

# Filtrar los elementos vacíos del array (csv)
$grupos.Where({ $_ -ne ""})

# Filtrar elementos únicos, elimina repeticiones
$gruposUnicos = $grupos | Sort-Object -Unique

# Importa los Grupos del sistema a un array
$gruposSystema = @()
$gruposSystema+= (Get-LocalGroup).Name

# Compara grupos sistema con grupos csv
foreach($grupo in $gruposUnicos){
    if (!($grupo -in $gruposSystema)){
        Write-Host 'El grupo ' $grupo ' NO EXISTE'
    }

}

