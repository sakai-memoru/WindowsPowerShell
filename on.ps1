$p= $PWD.Path.split("\")[-1]
cd $Env:workon_home\$p
.\Scripts\activate
cd $Env:project_home\$p
