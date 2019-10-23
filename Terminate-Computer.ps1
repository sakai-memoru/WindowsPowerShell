$journal_path = 'G:\Users\sakai\OneDrive\Documents\journal'
cd $journal_path

# git commit
git add .
git commit -m "Sync from PC Desktop"
git push origin master

# shutdown
Stop-Computer 