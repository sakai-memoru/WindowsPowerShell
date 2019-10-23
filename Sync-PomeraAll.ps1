cd ($PROFILE | Split-Path -Parent)
. .\Sync-GitJournal.ps1
echo 'RUN sync-gitjournal -------------'
Run-Process

. .\Sync-PomeraMemo.ps1
echo 'RUN sync-PomeraMemo -------------'
Run-Process

