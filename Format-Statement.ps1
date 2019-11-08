
function Get-Config($script_folder, $config_file='config.psd1')
{
  $config_path = Join-Path $script_folder $config_file
  $config = Import-PowerShellDataFile $config_path
  ## return 
  $config
}

function Run-Process($text, $config)
{
  foreach($key in $config.C_before_keywords)
  {
    $keystate = ' ' + $key + ' '
    $text = $text -replace $key, $keystate
    $CRkeystate = "`r`n" + $keystate
    $text = $text -replace $keystate, $CRkeystate
  }
  
  foreach($key in $config.C_after_keywords)
  {
    $keystate = ' ' + $key + ' '
    $text = $text -replace $key, $keystate
    $keystateCR = $keystate + "`r`n"
    $text = $text -replace $keystate, $keystateCR
  }

  $text = $text -replace " +", " "
  $ary_rtn = @()
  $ary = $text -split "`r`n"
  foreach($a in $ary)
  {
    $ary_rtn += $a.Trim()
  }
  ## return
  $ary_rtn

}


## ---------------------------------------------------- // entry point
##
If ((Resolve-Path -Path $MyInvocation.InvocationName).ProviderPath -eq $MyInvocation.MyCommand.Path) 
{

$script_folder = Split-Path $MyInvocation.InvocationName -Parent

$config = Get-Config $script_folder

$text = @"
SELECT id, name FROM table ;
"@

Run-Process $text $config

}