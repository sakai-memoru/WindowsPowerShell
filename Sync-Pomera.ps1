## constants
$pomera_path = 'I:\Pomera'
$pomera_pc_sync = 'G:\Users\sakai\OneDrive\Documents\ml19b.wiki'
$target_mdtxt = "*.md.txt"

function Add-YamlHeader($file)
{
  $flg = $False
  $ary = @()
  $created_dtm = $file.CreationTime
  $created_str = $created_dtm.ToString("yyyy-MM-ddTHH:mm:ssK")
  $file_name_md = (Get-Title $file) + '.md'
  $template = @"
---
created: $created_str
file name: $file_name_md
---

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

function Replace-TitleForFileName($title)
{
  (($title.Replace(' ','_')).Replace(':','')).Replace('/','')
}

function Shorten-Title($title)
{
  if($title.Length -gt 34)
  {
    $title.Substring(0,34) + '…'
  }
  else
  {
    $title
  }
}

function Get-Title($file)
{
  $ret = ($file.CreationTime).ToString("yyyyMMdd_HHmm_P")
  $flg = $False
  $file_name = $file.Fullname
  Get-Content $file_name | set -Name lines
  foreach($line in $lines)
  {
    if($line.StartsWith('# '))
    {
      $ret = Replace-TitleForFileName $line.Substring(2,$line.Length-2).Trim()
      $flg = $True
    }
    if($flag) { Break }
  }
  ## return
  $ret
}

function Run-Process()
{
  echo '----------------Start ..'
  dir $pomera_path -filter $target_mdtxt | set -name dir_list
  
  foreach($f in $dir_list)
  {
    echo "target is $f"
    $lines = Add-YamlHeader $f
    $title = Get-Title $f
    $file_name_md = $title + '.md'
    $file_name_txt = (Shorten-Title $title) + '.txt'
    $file_path_pomora = Join-Path $pomera_path $file_name_txt
    $file_path_pcsync = Join-Path $pomera_pc_sync $file_name_md
    #echo $file_name_md
    if(Test-Path $file_path_pcsync)
    {
      Remove-Item $file_path_pcsync
    }
    Set-Content -Path $file_path_pomora -Value $lines -Encoding UTF8
    Remove-Item $f.FullName
    Set-Content -Path $file_path_pcsync -Value $lines -Encoding UTF8
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

## git commit
cd $pomera_pc_sync
git add .
git commit -m 'sync from Pomera'
git push origin master

}
