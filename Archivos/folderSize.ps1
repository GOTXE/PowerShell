#requires –version 2.0

<#
   .Synopsis
    Lists the five largest folders and their size
   .Description
    This script lists the five largest folders and their size
   .Example
    ScriptingGamesBeginnerEvent8.ps1 -path C:fso -first 3
    Returns the three largest folders from within the C:fso parent directory
   .Inputs
    [string]
   .OutPuts
    [string]
   .Notes
    NAME:  ScriptingGamesBeginnerEvent8.ps1
    AUTHOR: Ed Wilson
    LASTEDIT: 5/20/2009
    KEYWORDS: 2009 SUmmer Scripting Games, Beginner Event 8, Get-ChildItem, Files and Folders
   .Link
     Http://www.ScriptingGuys.com
#Requires -Version 2.0
#>
Param(
 [string]$path = “C:\”,
 [int]$first = 10
)# end param

# *** Begin Functions ***

try {
function Get-DirSize {
<#
.Synopsis
  Gets a list of directories and sizes.
.Description
  This function recursively walks the directory tree and returns the size of
  each directory found.
.Parameter path
  The path of the root folder to start scanning.
.Example
  (Get-DirSize $env:userprofile | sort Size)[-2]
  Get the largest folder under the user profile.
.Example
  Get-DirSize -path “c:data” | Sort-Object -Property size -Descending
  Displays folders and sub folders from c:data in descending size order
.Outputs
  [PSObject]
.Notes
 NAME:  Get-DirSize
 AUTHOR: ToJo2000
 LASTEDIT: 8/12/2009
 KEYWORDS: 2009 Summer Scripting Games, Beginner Event 8, Get-ChildItem, Files and Folders
.Link
 Http://www.ScriptingGuys.com
#Requires -Version 2.0
#>

  param([Parameter(Mandatory = $true, ValueFromPipeline = $true)][string]$path)
  BEGIN {}
 
  PROCESS{
    $size = 0
    $folders = @()


 
    foreach ($file in (Get-ChildItem $path -Force -ea SilentlyContinue)) {
      if ($file.PSIsContainer) {
        $subfolders = @(Get-DirSize $file.FullName)
        $size += $subfolders[-1].Size
        $folders += $subfolders
      } else {
        $size += $file.Length
      }
    }
 
    $object = New-Object -TypeName PSObject
    $object | Add-Member -MemberType NoteProperty -Name Folder `
                         -Value (Get-Item $path).FullName
    $object | Add-Member -MemberType NoteProperty -Name Size -Value $size
    $folders += $object
    Write-Output $folders
  }
 
  END {}
} # end function Get-DirSize

} catch{

Out-File -FilePath "C:\Users\GTX\Desktop\Log.txt" 

}

Function Get-FormattedNumber($size)
{
 <#
   .Synopsis
    Formats a number into Gig, Meg, or Kilo
   .Description
    This function will format a number that is passed in bytes into
    Gigabytes, Megabytes, or Kilobytes as necessary. It displays two
    decimal places and the appropriate string qualifier. It should
    be used only to format string output. This function does not maintain
    technical precision, but rounds to the nearest two decimal places.
   .Example
    Get-FormattedNumber -size 1025
    Displays 1.00 KiloBytes
   .Example
    Get-FormattedNumber -size 1026
    Displays 9.79 MegaBytes
   .Example
    Get-FormattedNumber -size 10261024
    Displays 1.00 KiloBytes
   .Inputs
    [int32]
   .OutPuts
    [string]
   .Notes
    NAME:  Get-FormattedNumber
    AUTHOR: Ed Wilson
    LASTEDIT: 8/12/2009
    KEYWORDS: Format number, admin constants, if/elseif/else,
    Dot Net framework format specifier, .NET Framework
   .Link
     Http://www.ScriptingGuys.com
#Requires -Version 2.0
#>
  IF($size -ge 1GB)
   {
      “{0:n2}” -f  ($size / 1GB) + ” GigaBytes”
   }
 ELSEIF($size -ge 1MB)
    {
      “{0:n2}” -f  ($size / 1MB) + ” MegaBytes”
    }
 ELSE
    {
      “{0:n2}” -f  ($size / 1KB) + ” KiloBytes”
    }
} #end function Get-FormattedNumber

 # *** Entry Point to Script ***
 
 if(-not(Test-Path -Path $path))
   {
     Write-Host -ForegroundColor red “Unable to locate $path”
     Help $MyInvocation.InvocationName -full
     exit
   }
 Get-DirSize -path $path |
 Sort-Object -Property size -Descending |
 Select-Object -Property folder, size -First $first |
 Format-Table -Property Folder,
  @{ Label=”Size of Folder” ; Expression = {Get-FormattedNumber($_.size)} }
