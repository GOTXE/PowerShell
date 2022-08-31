Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    ID = 4740
}