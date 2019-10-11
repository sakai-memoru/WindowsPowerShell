## constants
$pomera_path = 'I:\Pomera'
$pomera_sync = 'G:\workplace\ml19b.wiki'
$target = "*.md.txt"
$template = @"
---
created: $created_str
file name: $file_name_md
---
"@


function Add-YamlHeader($file)
{
  $ary = @()
  $created_dtm = $file.CreationTime
  $created_str = $created_dtm.ToString("yyyy-MM-ddTHH:mm:ssK")
  # $file_name = $file.Fullname
  # $file_name_md = (Split-Path $file_name -leaf) -replace '.txt',''
  $file_name_md = (Get-Title $file) + '.md'
  
  $ary += $template
  Get-Content $file_name | set -Name lines
  $ary += $lines
  Write-Output $ary
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
      $ret = ($line.Substring(2,$line.Length)).Trim()
      $flg = $True
    }
    if($flag) { Break }
  }
  ## return
  $ret
}



function Run-Process()
{
  dir $pomera_path -filter $target | set -name dir_list 
  
  ## modify contents for GitJournal
  ## ◎-Loop
  foreach($f in $dir_lst)
  {
    $lines = Add-YamlHeader $f
    Set-Content -Path $f.FullName -Value $lines -Encoding UTF8
  }
  ## ●-Loop End
  
  if($dir_list.Count -ne 0)
  {
    foreach($f in $dir_list)
    {
      $file_name = $f.FullName
      $file_name_md = $file_name -replace '.txt',''
      Rename-Item -NewName {$f.Name -replace '.txt',''}
    }
    
    dir $pomera_sync -filter $target | set -name dir_list2
    $dir_list2 | Rename-Item -NewName {$_.Name -replace '.txt',''}
  }
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

if(-not (Test-Path $pomera_sync))
{
  $err = New-Object System.Exception "not found $pomera_sync"
  Throw $err
}

Run-Process

## git commit
cd $pomera_sync
git add .
git commit -m 'sync from Pomera'
git push origin master

}
