## ◆◇
Add-Type -AssemblyName System.Web

## env
$WIKI_URL = 'https://scrapbox.io/ml19b/'

function Encode-UrlString($url)
{
  $Encode = [System.Web.HttpUtility]::UrlEncode($url) 
  ## return
  $Encode
}

$text = Get-Clipboard

if($text.Trim())
{
  $target_path = $WIKI_URL + (Encode-UrlString $text)
}
else
{
  $target_path = $WIKI_URL
}

Set-Clipboard $target_path
