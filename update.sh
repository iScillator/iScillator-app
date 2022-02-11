read -t 3  COMMENT

BUILDNAME=`cat app/build.name`
BUILDNUMBER=`cat app/build.number`


git add .
#git pull --all
git pull  origin HEAD

git commit -a -m "$BUILDNAME+$BUILDNUMBER $COMMENT"
#git push --all
git push -u origin HEAD
