VERSION=$1

echo set version $VERSION

cd lib
cd config
cd current
rm current.dart
ln -s current.dart.$VERSION current.dart
cd ..
cd ..
cd ..

cd android
cd app
rm build.gradle
ln -s build.gradle.$VERSION build.gradle
cd src
cd main
rm AndroidManifest.xml
ln -s AndroidManifest.xml.$VERSION AndroidManifest.xml
cd ..
cd ..
cd ..
cd ..