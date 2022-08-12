$computerSystem = Get-WmiObject Win32_ComputerSystem
$nombreSistema = $computerSystem.name

$csv = "Path\test.csv"
$xlsx = "Path\"+$nombreSistema+'.xlsx'

# Exportar csv a excel formateado
# Definir delimitador
$delimiter = ","

# Crear excel nuevo con hoja vacía
$excel = new-object -ComObject excel.application
$workbook = $excel.workbooks.add(1)
$worksheet = $workbook.worksheets.item(1)


# Construir las tablas de query y reformaterar datos
$TxtConnector = ("TEXT;" + $csv)
$Connector = $worksheet.QueryTables.add($TxtConnector,$worksheet.Range("A1"))
$query = $worksheet.QueryTables.item($Connector.name)
$query.TextFileOtherDelimiter = $delimiter
$query.TextFileParseType = 1
$query.TextFileColumnDataTypes = ,1 * $worksheet.Cells.Columns.Count
$query.AdjustColumnWidth = 1

# Ejecutar y eliminarl la query de importaicion
$query.Refresh()
$query.Delete()

# Guardar y salir del libro de XLSX
$worksheet.Name = $nombreSistema
$Workbook.SaveAs($xlsx,51)
$excel.Quit()
