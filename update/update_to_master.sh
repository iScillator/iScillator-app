cd ..
git add .
#git pull --all
git pull  origin HEAD

git commit -a -m "+"
#git push --all
git push -u origin HEAD
git push -u origin HEAD:main
cd update

