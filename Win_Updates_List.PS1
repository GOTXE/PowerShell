Get-Hotfix #Muestra todas las instalaciones en formato tabla

Get-Hotfix |Select-Object Description,HotFixID,InstalledOn |Sort-Object installedOn

Get-Hotfix xxxxxxx |Select-Object -property * # xxxxxx es el numero de la kb, muestra los datos de esa actualizacion
