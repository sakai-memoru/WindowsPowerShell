$chrome = '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"'
$WIKI_URL = 'https://scrapbox.io/sakai-memoru/'
$value = Get-Clipboard

if($value)
{
  $target_path = $WIKI_URL + $value.Replace(' ','_')
}
else
{
  $target_path = $WIKI_URL
}

Start-Process -FilePath $chrome -ArgumentList $target_path
