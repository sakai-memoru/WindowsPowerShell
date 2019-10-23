## ◆◇
Add-Type -AssemblyName System.Web

## env
$chromeexe = '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"'
$WIKI_URL = 'https://scrapbox.io/ml19b/'

## const
$body = @"
[FIXME]
$lines

"@


function Get-Body($text){
$body = @"
[FIXME]

1234566

"@
  $lines = "1234556`r`n"
  $body
}

function Get-Title($text){
  'title-dummy'
}

function Encode-UrlString($url)
{
  $Encode = [System.Web.HttpUtility]::UrlEncode($url) 
  ## return
  $Encode
}

$text = Get-Clipboard

$title = Get-Title $text
$body = Get-Body $text

if($title.Trim())
{
  $target_path = $WIKI_URL + (Encode-UrlString $title) + '?body=' + (Encode-UrlString $body)
}
else
{
  $target_path = $WIKI_URL
}

$target_path

Start-Process -FilePath $chromeexe -ArgumentList $target_path
