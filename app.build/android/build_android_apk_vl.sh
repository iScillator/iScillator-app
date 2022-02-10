VERSION="vl"
cd ..
cd ..
cd app

../app.build/set_version.sh $VERSION

BUILDNAME=`cat build.name`
BUILDNUMBER=`cat build.number`
BUILDNUMBER=$((BUILDNUMBER+1))
echo $BUILDNUMBER >build.number

echo "const buildName=\"$BUILDNAME\";"> lib/config/version.dart
echo "const buildNumber=$BUILDNUMBER;">> lib/config/version.dart


echo "flutter build apk --split-per-abi --build-name=$BUILDNAME --build-number=$BUILDNUMBER"
flutter build apk --split-per-abi --build-name=$BUILDNAME --build-number=$BUILDNUMBER
mv build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk ../app.build/release/app-armeabi-v7a-release.$VERSION.$BUILDNAME.$BUILDNUMBER.apk

VERSION="dev"

../app.build/set_version.sh $VERSION

cd ..
cd app.build
cd android