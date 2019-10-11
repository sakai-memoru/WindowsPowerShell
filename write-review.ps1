## constant
$C_out_directory = 'memo'
$document_directory = [environment]::GetFolderPath('mydocuments')
$sakura_macro = 'G:\Users\sakai\AppData\Roaming\sakura\insert-memo-line.mac'
$dtm = Get-Date

## variables
$dtm_str = $dtm.ToString('yyMMdd')
$dtm_str2 = $dtm.ToString('yy/MM/dd HH:mm')
$memo_file_name = 'review_' + $dtm_str + '.md'
$yymm = ($dtm_str).Substring(0,4) + '-'

## template
$template = @"
# $memo_file_name

created : $dtm_str2

## ■□ $yymm

### overview
- 

### contents
- 

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

sakura $memo_path -M=G:\Users\sakai\AppData\Roaming\sakura\insert-ReviewLine.mac
