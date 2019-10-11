#$fileWatcher = New-Object System.IO.FileSystemWatcher

#$fileWatcher| Get-Member -Type Method

#$fileWatcher| Get-Member -Type Event

#$fileWatcher| Get-Member -Type Property

$watchDirPath = $Args[0]
$logPath = $Args[1]
 
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "$watchDirPath"
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true 
 
$action = { $path = $Event.SourceEventArgs.FullPath
            $changeType = $Event.SourceEventArgs.ChangeType
            $logline = "$(Get-Date), $changeType, $path"
            Add-content $logPath -value $logline
          }    
 
 
Register-ObjectEvent $watcher "Created" -Action $action
Register-ObjectEvent $watcher "Changed" -Action $action
Register-ObjectEvent $watcher "Deleted" -Action $action
Register-ObjectEvent $watcher "Renamed" -Action $action
while ($true) {sleep 1}