$pomera_sync = 'G:\workplace\ml19b.wiki'
## git commit
cd $pomera_sync
git add .
git commit -m 'sync from Pomera'
git push origin master

$pomera_pc_sync = 'G:\Users\sakai\OneDrive\Documents\journal'
## git commit
cd $pomera_pc_sync
git add .
git commit -m 'sync from Pomera'
git push origin master
