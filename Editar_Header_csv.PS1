# Para editar las cabeceras de las columnas en csv se usa label

# Ejemplo: @{label="Lo que sea";expression={$_."xxxxxxx"}}}

 ..... Select-Object @{label="Nombre";expression={$_."GivenName"}},@{label="Apellidos";expression={$_."SurName"}},@{label="usuario";expression={$_."UserPrincipalName"}},@{Name="Fecha Expiración";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}| Export-Csv -Path $export -NoTypeInformation -Encoding UTF8