## constant
$C_out_directory = 'memo'
$document_directory = [environment]::GetFolderPath('mydocuments')
$powershell_folder = 'WindowsPowerShell'

## path setting
$pwsh_directory = Join-path $document_directory $powershell_folder 

explorer $pwsh_directory
