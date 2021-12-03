export PATH="$PATH:/Users/anton/development/flutter/bin"

flutter create .
flutter pub get
cd ios
pod install
flutter run
# --no-sound-null-safety
