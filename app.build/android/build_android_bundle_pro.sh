VERSION="pro"
cd ..
cd ..
cd app

../build/set_version.sh $VERSION

flutter build appbundle

cp build/app/outputs/bundle/release/app-release.aab build/app/outputs/bundle/release/app-release-$VERSION.aab

VERSION="dev"

../build/set_version.sh $VERSION

cd ..
cd build
cd android