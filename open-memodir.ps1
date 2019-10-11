## constant
$C_out_directory = 'memo'
$document_directory = [environment]::GetFolderPath('mydocuments')

## path setting
$memo_directory = Join-path $document_directory $C_out_directory 

explorer $memo_directory
