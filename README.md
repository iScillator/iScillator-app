# iScillator (SoundHealer)

A cross-platform Flutter application for procedural sound generation, focusing on smooth frequency transitions and sound presets inspired by solfeggio and chakra frequencies.

## Features
- **Procedural Sound Generation:** Generate tones with smooth frequency transitions.
- **Preset System:** Choose from a set of sound presets (e.g., Muladhara, Svadhisthana, Manipura, etc.).
- **Customizable Wave Types:** Supports sinusoidal, square, triangle, sawtooth, and multi-wave types.
- **User Settings:** Save and load user preferences (wave type, balance, etc.).
- **Modern UI:** Gradient backgrounds, large frequency display, and intuitive controls.
- **Cross-Platform:** Runs on Android and iOS (with AudioKit integration for iOS).

## Screenshots
Add screenshots of the app UI here (e.g., from `app/images/` if available).

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Xcode (for iOS)
- Android Studio (for Android)

### Installation
```sh
# Clone the repository
 git clone <your-repo-url>
 cd iScillator-app/app

# Get dependencies
 flutter pub get
```

### Running the App
```sh
# For Android
dart
flutter run -d <android-device-id>

# For iOS
flutter run -d <ios-device-id>
```

## Project Structure
- `app/lib/` - Main Flutter source code
  - `main.dart` - App entry point
  - `screens/` - UI screens (main, settings, etc.)
  - `models/` - Data models (e.g., user settings)
  - `plugins/` - Plugin registrant
  - `packages/sound_generator/` - Local sound generation package
- `app/images/` - UI assets (play/pause buttons)
- `app/android/`, `app/ios/` - Platform-specific code
- `build_apk.sh`, `build_bundle.sh` - Build scripts
- `docs/` - Additional documentation

## Building for Release
- **Android:** Use `build_apk.sh` or `build_bundle.sh` for APK/AAB builds.
- **iOS:** Open `ios/Runner.xcworkspace` in Xcode for signing and App Store upload.

## Contribution
Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License
See the `LICENSE` file in the `app/lib/packages/sound_generator/` directory for details.

