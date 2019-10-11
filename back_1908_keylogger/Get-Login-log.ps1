#get-winevent -logname Security -filterxpath "*[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and (EventID='4624' or EventID='4634')]]" -maxevents 120
#GET-WinEvent Security | Where-Object{$_.Id -eq 4624 -or $_.Id -eq 4672} | select-Object TimeCreated,Id,Message -last 20

#GET-WinEvent Security | Where-Object{$_.Id -eq 7001 -or $_.Id -eq 7002} | select-Object TimeCreated,Id,Message

Get-WinEvent -LogName System -FilterXPath "*[System[Provider[@Name='Microsoft-Windows-Kernel-General'] and (EventID='12' or EventID='13')]]" -maxevents 10