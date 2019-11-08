## constant
$C_out_directory = 'journal'
$document_directory = [environment]::GetFolderPath('mydocuments')

## variables
$dtm_str = Get-Date -f "yyMMdd"
$memo_file_name = $dtm_str + '.md'
$dtm_str2 = Get-Date -Format "yyyy-MM-ddTHH:mm:ssK"

## template
$template = @"
---
created: $dtm_str2
---

# $dtm_str.md :

"@

## path setting
$memo_directory = Join-path $document_directory $C_out_directory 
$memo_path = Join-Path $memo_directory $memo_file_name

## test path
if(-not (test-path $memo_directory))
{
  New-Item $memo_directory -ItemType Directory
}

if(-not (test-path $memo_path))
{
  New-Item $memo_path -ItemType File -Value $template
}

sakura $memo_path -M=G:\Users\sakai\AppData\Roaming\sakura\insert-memo-line.mac
