library my_prj.globals;

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

import '/models/user_settings.dart';
import '/config/configs.dart';
import '/config/current.dart';

var sg;
var setState;
var setParams;
var pageController;
var showPresetWindow;

// TODO: FIX:
var SoundGenerator;
var SoundGenerator1;

SharedPreferences? prefs;

var _isPresetWindowShown = {
  "audios": false,
  "folders": false,
  "program": false,
  "angles": false,
  "enviroments": false,
  "modulations": false,
  "multis": false,
  "targets": false,
  "audioDevices": false,
};

final Map<String, dynamic> defaults = config["defaults"];
final defaultSettings = defaults;

final Map<String, dynamic> userSettings = {
  "folder": defaultSettings["folder"],
  "program": defaultSettings["program"],
  "angle": defaultSettings["angle"],
  "enviroment": defaultSettings["enviroment"],
  "modulation": defaultSettings["modulation"],
  "multi": defaultSettings["multi"],
  "target": defaultSettings["target"],
  "audioDevice": defaultSettings["audioDevice"]
};

bool isPlaying = false;
double frequency = 0;
var selectedPage = 0;

final config_current_os =
    (Platform.isIOS ? "ios/" : "android/") + config_current;

//final config_current_os = "ios/com.soundhealer.pro";

final config = configs[config_current_os];

final Map<String, dynamic> menu = config["menu"];

final Map<String, dynamic> menu_rev = {
  "audios": (menu["audios"] != null
      ? menu["audios"].map((k, v) => MapEntry(v, k))
      : {}),
  "channels": (menu["channels"] != null
      ? menu["channels"].map((k, v) => MapEntry(v, k))
      : {}),
  "enviroments": (menu["enviroments"] != null
      ? menu["enviroments"].map((k, v) => MapEntry(v, k))
      : {}),
  "modulations": (menu["modulations"] != null
      ? menu["modulations"].map((k, v) => MapEntry(v, k))
      : {}),
  "multis": (menu["multis"] != null
      ? menu["multis"].map((k, v) => MapEntry(v, k))
      : {}),
  "targets": (menu["targets"] != null
      ? menu["targets"].map((k, v) => MapEntry(v, k))
      : {}),
};
