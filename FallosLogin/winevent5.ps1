(Get-WinEvent -ListProvider Microsoft-Windows-GroupPolicy).Events | Format-Table Id, Description