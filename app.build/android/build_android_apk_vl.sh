VERSION="vl"
cd ..
cd ..
cd app

../app.build/set_version.sh $VERSION

flutter build apk --split-per-abi
mv build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk build/app/outputs/flutter-apk/app-armeabi-v7a-release-vl.apk

VERSION="dev"

../app.build/set_version.sh $VERSION

cd ..
cd app.build
cd android