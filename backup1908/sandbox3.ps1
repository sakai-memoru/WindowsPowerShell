function porcess-keystrokes-by-minute($target_keystroke_path)
{
  ## load data
  $data = Import-Csv -Delimiter `t -Encoding $setting.C_encode -LiteralPath $target_keystroke_path
  $data[0]
  $alpha_cnt = $data[0].alpha_cnt
  $other_cnt = $data[0].other_cnt
  $logger.debug.Invoke($alpha_cnt)
  $logger.debug.Invoke($other_cnt)
  
  ## loop-process
  $i = 0
  ForEach($dat in $data)
  {
    $logger.debug.Invoke("dat.created = " + $dat.created)
    $logger.debug.Invoke("dat.processid = " + $dat.processid)
    $logger.debug.Invoke("dat.app_name = " + $dat.app_name)
    $logger.debug.Invoke("dat.alpha_cnt = " + $dat.alpha_cnt)
    $logger.debug.Invoke("dat.numeric_cnt = " + $dat.numeric_cnt)
    $logger.debug.Invoke("dat.symbol_cnt = " + $dat.symbol_cnt)
    $logger.debug.Invoke("dat.other_cnt = " + $dat.other_cnt)
    $i = $i + 1
    if($i -gt 10){break}
  }
  # return

}

cd G:\workplace\transformPCActiveInfo

$project_name = split-path $PWD.path -leaf
$setting = Import-PowerShellDataFile -LiteralPath "./$project_name.psd1"

## include logger
. ./Get-Logger.ps1

$logger = Get-Logger  -VerbosePreference $setting.VerbosePreference
$logger.debug.Invoke("get config from ./$project_name.psd1")
$logger.debug.Invoke("mode : debug")

($MyInvocation.MyCommand.Path -split "\.")[0]
# pathの扱い

## get keystrokes files from input directory
$keystroke_files = @(Get-ChildItem $setting.C_input_directory | Where-object {$_.Name -match $setting.C_input_file_name_keystroke})
    
## ◎-loop process keystrokes files
foreach($keystroke_file in $keystroke_files)
{
  $target_keystroke_path = Join-Path $setting.C_input_directory $keystroke_file
  porcess-keystrokes-by-minute $target_keystroke_path
}
