## include configs
$project_name = split-path $PWD.path -leaf
$setting = Import-PowerShellDataFile -LiteralPath "./$project_name.psd1"

## include logger
. ./Get-Logger.ps1

$logger = Get-Logger  -VerbosePreference $setting.VerbosePreference

$logger.debug.Invoke("get config from ./$project_name.psd1")
$logger.debug.Invoke("mode : debug")
$logger.info.Invoke($setting.C_input_directory)
