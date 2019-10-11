## constant
$C_out_directory = 'journal'
$document_directory = [environment]::GetFolderPath('mydocuments')

## variables
$dtm_str2 = Get-Date -UFormat "%y/%m/%d %a %R"
$dtm_str3 = get-date -Format "yyyy-MM-ddTHH:mm:ssK"
$dtm_str = $dtm_str3.Replace(":","_")
$memo_file_name = $dtm_str + '_D.md'

## path setting
$memo_directory = Join-path $document_directory $C_out_directory 
$memo_path = Join-Path $memo_directory $memo_file_name

## template
$template = @"
---
created: $dtm_str3
file name: $memo_file_name
---
# $memo_file_name
- $dtm_str2

## Facts (What)
- 

## Interpretation
- 

## Action / Strategies (How)
- 

## Insight (Why)
- 

"@

## test path
if(-not (test-path $memo_directory))
{
  New-Item $memo_directory -ItemType Directory
}

## git commit
cd $memo_directory
git add .
git commit -m 'sync from Desktop PC'
git push origin master

Set-Clipboard $template

sakura $memo_path -M=G:\Users\sakai\AppData\Roaming\sakura\paste_clipboard.mac