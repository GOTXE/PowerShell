# POWERSHELL GUI

Add-Type -AssemblyName system.windows.forms

$FormObject = [System.Windows.Forms.Form]
$LabelObject = [System.Windows.Forms.Label]

$HelloWorldForm = New-Object $FormObject
$HelloWorldForm.ClientSize='500,300'
$HelloWorldForm.Text='Hello World - Tutorial'
$HelloWorldForm.BackColor="#ffffff"


$lbltitle=new-object $LabelObject
$lbltitle.Text='Hola Caracola'
$lbltitle.AutoSize=$true
$lbltitle.location=New-Object System.Drawing.Point(120,110)
$lbltitle.Font='Verdana,24,style=Bold'


$HelloWorldForm.Controls.AddRange(@($lbltitle))

# Display the form
$HelloWorldForm.ShowDialog()

## Cleans up the form
$HelloWorldForm.Dispose()