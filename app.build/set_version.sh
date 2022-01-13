VERSION=$1

echo set version $VERSION

cd lib
cd config
cd current
rm current.dart
ln -s current.$VERSION.dart current.dart
cd ..
cd ..
cd ..

cd android
cd app
rm build.gradle
ln -s build.$VERSION.gradle build.gradle
cd src
cd main
rm AndroidManifest.xml
ln -s AndroidManifest.$VERSION.xml AndroidManifest.xml
cd ..
cd ..
cd ..
cd ..