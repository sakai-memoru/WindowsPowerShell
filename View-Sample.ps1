<#
.SYNOPSIS
  View-Sample 

.DESCRIPTION
  Can view a sample template for scripting help documents

.EXAMPLE
  PS C:\> View-Sample.ps1

.EXAMPLE
  PS C:\> View-Sample.ps1 -Detail

.PARAMETER Detail
  View in detail

.INPUTS
  NONE

.OUTPUTS
  System.Int32
  If end normal, return 0. 

.NOTES
  Nothing special.
  Type `Get-Help about_Comment_Based_Help`
#>

param(
  [switch]$Detail     # Detail Mode
)

function Run-Process($Args)
{
  if($Args)
  {
    echo 'Hello Detail.'
  }
  else
  {
    echo 'Hello.'
  }
}

## ---------------------------------------------------- // entry point
#
If ((Resolve-Path -Path $MyInvocation.InvocationName).ProviderPath -eq $MyInvocation.MyCommand.Path) 
{

Run-Process $Args
echo $Detail

}