<#
.SYNOPSIS
    Creates and calls a function to capitalize initial letters of words
.DESCRIPTION
    Creates and calls a function to capitalize initial letters of words, where the words in the
    string passed to the function can be separated by spaces, hyphens or other non-alphanumeric
    characters (i.e. "word boundary" characters. The function does try to un-capitalize letters
    following apostrophes within words.
.NOTES
    Filename: ConvertTo-CapitalizedWords.ps1
    Author:   Charles Joynt
    History:  19/01/2011 script created
.LINK
    https://github.com/cjj1977/PSToolkit/blob/master/Public/ConvertTo-CapitalizedWords
.EXAMPLE
    [PS]>ConvertTo-CapitalizedWords.ps1
.EXAMPLE
    [PS]>ConvertTo-CapitalizedWords.ps1 -Text "hello-world"
    Hello-World
.EXAMPLE
    [PS]>ConvertTo-CapitalizedWords.ps1
    
    [PS]>ConvertTo-CapitalizedWords -Text "hello-world"
    Hello-World
#>
function ConvertTo-CapitalizedWords{
    param(
      [string]$Text
    )
    Write-Debug "Capitalizing $Text"
  
    # Capitalize all letters following a word boundary
    $CapitalizedWords = [Regex]::Replace($Text,'\b\w',{param($string) $string.Value.ToUpper()})
  
    # Fix capitalization of letters following apostrophes within words
    $CapitalizedWords = [Regex]::Replace($CapitalizedWords,'\w''\w', {
      param($string)
      
      $string.Value.Substring(0,2) + $string.Value.Substring(2,1).ToLower()
    })
  
    return $CapitalizedWords
}