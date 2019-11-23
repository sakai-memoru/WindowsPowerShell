######################
# exec-grepOnSakuraWithSendtoFiles.ps1
#
#   execute sakura grep in sendto with powershell
# 

## confirm for debug 
# foreach($arg in $args){
#   echo "L002 :$arg"
#   $arg.GetType()
# }
## data for debug 
# ## files 
# $aryArg = @(
#   "G:\Users\sakai\AppData\Roaming\sakura\lib\DateUtil.jse",
#   "G:\Users\sakai\AppData\Roaming\sakura\lib\StringUtil.jse",
#   "G:\Users\sakai\AppData\Roaming\sakura\lib\Template.jse",
#   "G:\Users\sakai\AppData\Roaming\sakura\lib\Clipboard3.jse"
# )
# ## folder  
# $aryArg = @(
#   "G:\Users\sakai\AppData\Roaming\sakura\lib"
# )

## -------------------------------------------------------------
## args -> aryArg
#$args | select $_.Name | set -Name aryArg


## const
#$C_GOPT = 'SPH'
$C_GOPT = "P"
$C_GCODE = 4
$C_DEFAULT_FILE = '*.*' ## When a folder selected
$C_MESSAGE = 'Strings for grep search'
$C_WINDOWSTITEL = 'input'

# open sakura grep from sendto
echo '----------------- process start!'

Add-Type -AssemblyName Microsoft.VisualBasic
Add-Type -Assembly System.Windows.Forms;


## variable
$files = ''
$aryFiles = @()
$defaultText = [System.Windows.Forms.Clipboard]::GetText();
#echo $defaultText

## get clipboard
$key = [Microsoft.VisualBasic.Interaction]::InputBox($C_MESSAGE, $C_WINDOWTITEL,$defaultText);
echo $key

## arg processing
if($aryArg.Length -eq 1){
  ## if selected one file or selected one foldr
  $itm = Get-Item $aryArg[0] 
  if($itm -is [System.IO.DirectoryInfo]){
    $aryFiles += $C_DEFAULT_FILE
    $folder = $itm.FullName
  }
  else
  {
    $aryFiles += $itm.Name
    $folder = $itm.DirectoryName
  }
}
else
{
  ## if selected some files , ignore a folder object selected.
  for($i = 0; $i -lt $aryArg.Length; $i++){
    $itm = Get-Item $aryArg[$i] 
    if(-not ($itm -is [System.IO.DirectoryInfo])){
      $aryFiles += $itm.Name
      $folder = $itm.DirectoryName
    } 
  }
}

## make command line statement
$files = $aryFiles -join ','
$C_CMD_STATEMENT = "sakura -GREPMODE -GKEY=$key -GFILE=""$files"" -GFOLDER=$folder -GCODE=$C_GCODE -GOPT=$C_GOPT"
echo $C_CMD_STATEMENT

## execute
Invoke-Expression $C_CMD_STATEMENT
