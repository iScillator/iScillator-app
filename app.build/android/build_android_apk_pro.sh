VERSION="pro"
cd ..
cd app

../build/set_version.sh $VERSION

flutter build apk --split-per-abi

VERSION="dev"

../build/set_version.sh $VERSION

cd ..
cd build