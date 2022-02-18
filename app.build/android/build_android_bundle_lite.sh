VERSION="lite"
cd ..
cd ..
cd app

../build/set_version.sh $VERSION

BUILDNAME=`cat build.name`
BUILDNUMBER=`cat build.number`
BUILDNUMBER=$((BUILDNUMBER+1))
echo $BUILDNUMBER >build.number

echo "const buildName=\"$BUILDNAME\";"> lib/config/version.dart
echo "const buildNumber=$BUILDNUMBER;">> lib/config/version.dart

flutter build appbundle  --build-name=$BUILDNAME --build-number=$BUILDNUMBER

mv build/app/outputs/bundle/release/app-release.aab ../app.build/release/app-armeabi-v7a-release.$VERSION.$BUILDNAME.$BUILDNUMBER.aab

VERSION="dev"

../build/set_version.sh $VERSION

cd ..
cd build
cd android