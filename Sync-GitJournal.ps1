## constants
$pomera_path = 'I:\Pomera_memo'
$pomera_pc_sync = 'G:\Users\sakai\OneDrive\Documents\journal'
$target_txt = "*.txt"

function Add-YamlHeader($file)
{
  $flg = $False
  $ary = @()
  $created_dtm = $file.CreationTime
  $created_str = $created_dtm.ToString("yyyy-MM-ddTHH:mm:ssK")
  $file_name = (Split-Path $file.fullname -leaf).Replace('.txt','')
  $template = @"
---
created: $created_str
file name: $file_name

---

# Pomera Diary

"@

  Get-Content $file.Fullname | set -Name lines
  foreach($line in $lines)
  {
    ## FIXME - if a file name is changed, change a YAML header.
    if($line.StartsWith('created:'))
    {
      $flg = $True
    }
  
  }
  if(-not $flg)
  {
    $ary += $template
  }
  Get-Content $file.Fullname | set -Name lines
  $ary += $lines
  Write-Output $ary
}


function Run-Process()
{
  echo '----------------Start ..'
  $yyyyMM = Get-Date -f "yyyyMM"
  $pomera_dairy_path = Join-Path $pomera_path $yyyyMM
  
  dir $pomera_dairy_path -filter $target_txt |sort CreationTime | set -name dir_list
  
  foreach($f in $dir_list)
  {
    echo "target is $f"
    $lines = Add-YamlHeader $f
    $file_name_txt = Split-Path $f.Fullname -leaf
    $file_name_txt_chopLeft = $file_name_txt.Substring(2)
    $file_name_md = $file_name_txt_chopLeft.Replace('.txt','_P.md')
    $file_path_pomora = Join-Path $pomera_dairy_path $file_name_txt
    $file_path_pcsync = Join-Path $pomera_pc_sync $file_name_md
    #echo $file_path_pcsync
    #echo $file_name_md
    $lines = Add-YamlHeader $f
    Set-Content -Path $file_path_pomora -Value $lines -Encoding UTF8
    Set-Content -Path $file_path_pcsync -Value $lines -Encoding UTF8
    Set-ItemProperty -Path $file_path_pcsync -Name LastWriteTime -Value $f.CreationTime
  }
  if($dir_list.Count -eq 0){ echo 'target file is NONE.'}
  echo '----------------end ..//'
}

## ---------------------------------------------------- // entry point
##
If ((Resolve-Path -Path $MyInvocation.InvocationName).ProviderPath -eq $MyInvocation.MyCommand.Path) 
{

if(-not (Test-Path $pomera_path))
{
  $err = New-Object System.Exception "not found $pomera_path"
  Throw $err
}

if(-not (Test-Path $pomera_pc_sync))
{
  $err = New-Object System.Exception "not found $pomera_pc_sync"
  Throw $err
}

Run-Process

}
