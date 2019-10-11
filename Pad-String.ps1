function Get-MaxLength($ary)
{
  $len = 0
  foreach($a in $ary)
  {
    if($len -lt $a.Length)
    {
      $len = $a.Length
    }
  }
  ## return
  $len
}


## ---------------------------------------------------- // entry point
##
If ((Resolve-Path -Path $MyInvocation.InvocationName).ProviderPath -eq $MyInvocation.MyCommand.Path) 
{

## include configs
$work_directory = $PROFILE | split-path -parent
$config_file_name = 'config.psd1'
$config_path = Join-Path $work_directory $config_file_name
$config = Import-PowerShellDataFile $config_path

$ary = @("sakai", "mitsuru", "sakai", "tamotsu")

$max_len = Get-MaxLength $ary
$max_len
$str = ''

foreach($a in $ary)
{
  $str = $str + $a.PadRight($max_len) + " | "
}

$outline = "| " + $str
$outline

  
}