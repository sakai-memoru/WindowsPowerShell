$chrome = '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"'
$WIKI_URL = 'https://scrapbox.io/ml19b/'
$value = Get-Clipboard

$target_path = $WIKI_URL + $value.Replace(' ','_')

Start-Process -FilePath $chrome -ArgumentList $target_path
