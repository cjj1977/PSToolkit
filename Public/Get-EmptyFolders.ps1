<#
.SYNOPSIS
      Creates and calls a function to Find empty sub-folders under the current path.
.DESCRIPTION
      Creates and calls a function to scan a folder heirarchy for any folders that
      do not contain other files or folders. The results are fed into an array, which
      is returned as an object.
.NOTES
      Filename: Get-EmptyFolders.ps1
      Author:   Charles Joynt
      History:  31/07/2009 script created
                14/11/2009 switches added
                06/04/2010 PSv2 'help' headers added
.LINK
      https://github.com/cjj1977/PSToolkit/blob/master/Public/Get-EmptyFolders
.EXAMPLE
      [PS]> Get-EmptyFolders
#>
function Get-EmptyFolders {
    [CmdletBinding()]
    [OutputType([System.IO.DirectoryInfo])]
    param(
        $Path = (Get-Location),
        $Exclude = ""
    )

    $Folders = Get-ChildItem -LiteralPath $Path -Directory -Recurse |
        Where-Object {$_.FullName -notlike $Exclude}

    foreach($Folder in $Folders) {
        if(($Folder.GetFiles().Count -eq 0) -and ($Folder.GetDirectories().count -eq 0)) {
            Write-Output $Folder
        }
    }
}