cd ($PROFILE | Split-Path -parent)
$config = Import-PowerShellDataFile -Path config.psd1
$ary = @()
$target_file = 'SSE19_Biz.asta'
foreach ($dir in $config.C_target_directory)
{
  $d = dir $dir $config.C_search_target -Recurse -Depth 2
  foreach ($my in $d)
  {
    $file = @(dir $my.Directory $targt_file -Recurse -Depth 2)
    if($file)
    {
      $file[0]
    }
  }
}
