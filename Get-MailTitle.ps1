
function process()
{
  echo '------start'
  
  # New Outlook COM object
  $objApp = New-Object -ComObject Outlook.Application
  $olObj = $objApp.GetNameSpace("MAPI")

  $olFolderInbox = 6
  $oFolder = $olObj.GetDefaultFolder($olFolderInbox)
  foreach($oItem in $oFolder.Items)
  {
    $oItem.Subject
  }
}

## -----------------------// entry point
$pwshdir = $PROFILE | Split-Path -Parent
$conf_file = "./config.psd1"
$conf_path = Join-Path $pwshdir $conf_file
$config = Import-PowerShellDataFile $conf_path

process