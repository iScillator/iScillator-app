# Sound Generator

This plugin is a procedural sound generator. It provides fluidly sound transitions in frequency changes.

You can see real signal shape with one Cycle snapshot properties

## Example Application Screenshot

#android install
flutter pub get

#ios install
cd ios/
pod install
cd ../
flutter pub get
flutter run


// iOS issues resolving:
// 1. Set AudioKit version in sound_generator.podspecs to: s.dependency 'AudioKit', '~> 4.11.1'
// 2. Set minimum iOS version in podfil to 13
// 3. Do the following changes in public init(registrar: FlutterPluginRegistrar) method implementation in SwiftSoundGeneratorPlugin:
//    ...
//    let messenger = (registrar as? NSObject)?.value(forKey: "messenger")
//      if messenger == nil {
//              return
//          }
//    let methodChannel = FlutterMethodChannel(name: "sound_generator", binaryMessenger: messenger as! FlutterBinaryMessenger)
//    self.onChangeIsPlaying = BetterEventChannel(name: "io.github.mertguner.sound_generator/onChangeIsPlaying", messenger: messenger as! FlutterBinaryMessenger)
//    self.onOneCycleDataHandler = BetterEventChannel(name: "io.github.mertguner.sound_generator/onOneCycleDataHandler", messenger: messenger as! FlutterBinaryMessenger)

// ignore_for_file: import_of_legacy_library_into_null_safe