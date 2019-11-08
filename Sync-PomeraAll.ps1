cd ($PROFILE | Split-Path -Parent)
. .\Sync-GitJournal.ps1
echo 'RUN sync-gitjournal -------------'
Run-Process

. .\Sync-Pomera.ps1
echo 'RUN sync-Pomera -------------'
Run-Process

