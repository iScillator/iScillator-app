VERSION="vl"
cd ..
cd ..
cd app

../app.build/set_version.sh $VERSION

flutter build apk --split-per-abi
mv build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk app.build/release/app-armeabi-v7a-release.$VERSION.apk

VERSION="dev"

../app.build/set_version.sh $VERSION

cd ..
cd app.build
cd android