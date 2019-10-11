## constant
$C_out_directory = 'journal'
$document_directory = [environment]::GetFolderPath('mydocuments')

## variables
$dtm_str2 = get-date -Format "yyyy-MM-ddTHH:mm:ssK"
$dtm_str = $dtm_str2.Replace(":","_")
$memo_file_name = $dtm_str + '.md'

## template
$template = @"
---
created: $dtm_str2
file name: $dtm_str.md
---
# Diary

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

if(-not (test-path $memo_path))
{
  New-Item $memo_path -ItemType File -Value $template
}

Invoke-Item $memo_path
