## constant
$C_out_directory = 'journal'
$document_directory = [environment]::GetFolderPath('mydocuments')

## variables
$dtm_str = (Get-Date).ToString('yyMMdd')
$dtm_str3 = Get-Date -UFormat "%y/%m/%d %a %R"
$memo_file_name = $dtm_str + '_E.md'
$dtm_str2 = get-date -Format "yyyy-MM-ddTHH:mm:ssK"

## template
$template = @"
---
created: $dtm_str2
file name : $memo_file_name
---
# $memo_file_name

## 78 pattern
- 

## Dictation
- 

## Copy and Type
### GIANT STEP 100
- 

## Tani Key
- 

## Words
- 

"@

## path setting
$memo_directory = Join-path $document_directory $C_out_directory 
$memo_path = Join-Path $memo_directory $memo_file_name

## git commit
cd $memo_directory
git add .
git commit -m 'sync from Desktop PC'

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
