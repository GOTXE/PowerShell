$PDCEmulator = (Get-ADDomain).PDCEmulator
Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
    LogName = 'Security'
    ID = 4625
}