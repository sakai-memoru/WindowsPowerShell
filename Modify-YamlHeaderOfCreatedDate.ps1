$memo_path = 'G:\workplace\ml19b.wiki'

$target = "2019\d{4}_\d{4}\.md"

dir $memo_path | where { $_.Name -match $target} | set -Name dir_lst

foreach($f in $dir_lst)
{
  $ary = @()
  $created_dtm = $f.CreationTime
  $created_str = $created_dtm.ToString("yyyy-MM-ddTHH:mm:ssK")

  Get-Content $f.FullName | set -Name lines
  foreach($line in $lines)
  {
    if($line.Startswith('created'))
    {
      $line = "created : $created_str"
    }
    $ary += $line
  }
  Set-Content -Path $f.FullName -Value (echo $ary) -Encoding UTF8
}

