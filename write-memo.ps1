## constant
$C_out_directory = 'memo'
$document_directory = [environment]::GetFolderPath('mydocuments')
$sakura_macro = 'G:\Users\sakai\AppData\Roaming\sakura\insert-memo-line.mac'

## variables
$dtm_str = (Get-Date).ToString('yyMMdd')
$memo_file_name = $dtm_str + '.md'

## template
$template = @"

# $dtm_str.md

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

sakura $memo_path -M=G:\Users\sakai\AppData\Roaming\sakura\insert-memo-line.js
