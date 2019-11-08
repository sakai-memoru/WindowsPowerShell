$pics = [Environment]::GetFolderPath('MyPictures')
$scan = 'scanning'
$base_folder = Join-Path $pics $scan
$today = Get-Date -f 'yyyy_MM_dd'

$target_folder = Join-Path $base_folder $today

Explorer $target_folder
