## constant
$C_out_directory = 'ml19b.wiki'
$document_directory = 'G:\workplace'

## variables
$dtm_str2 = get-date -Format "yyyy-MM-ddTHH:mm:ssK"
$dtm_str3 = ((($dtm_str2 -replace ':', '') -replace '-','') -replace 'T', '_')
$dtm_str = $dtm_str3.Substring(0, $dtm_str3.Length-5)
$memo_file_name = $dtm_str + '.md'

## template
$template = @"
---
created: $dtm_str2
---
# Draft

## Contents

- 

"@

## path setting
$memo_directory = Join-path $document_directory $C_out_directory 
$memo_path = Join-Path $memo_directory $memo_file_name

## git commit
cd $memo_directory
git add .
git commit -m 'sync from Desktop PC'
git push origin master

## test path
if(-not (test-path $memo_directory))
{
  New-Item $memo_directory -ItemType Directory
}

Set-Clipboard $template

sakura $memo_path -M=G:\Users\sakai\AppData\Roaming\sakura\paste_clipboard.mac
