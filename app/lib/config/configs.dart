import 'audios.dart';
import 'channels.dart';
import 'enviroments.dart';
import 'modulations.dart';
import 'multis.dart';
import 'programs.dart';
import 'targets.dart';
import 'defaults.dart';

import 'dart:io' show Platform;

const Map<String, dynamic> configs = {
  "android/com.soundhealer": {
    "title": "SoundHealer",
    "defaults": defaults_lite,
    "menu": {
      "programs": programs_lite,
      "targets": targets_lite,
    }
  },
  "ios/com.soundhealer": {
    "title": "SoundHealer",
    "defaults": defaults_lite,
    "menu": {
      "programs": programs_lite,
      "targets": targets_lite,
    }
  },
  "android/com.soundhealer.pro": {
    "title": "SoundHealer PRO",
    "defaults": defaults_pro,
    "menu": {
      "programs": programs_pro,
      "targets": targets_pro,
      "enviroments": enviroments,
      "modulations": modulations,
      "multis": multis,
      "audios": audios,
      "channels": channels
    }
  },
  "dev.soundhealer.com": {"title": "SoundHealer DEV"},
  "yl.soundhealer.com": {"title": "SoundHealer Young Living Edition"}
};

final config_current = "com.soundhealer.pro";
final config_current_os =
    (Platform.isIOS ? "ios/" : "android/") + config_current;

//final config_current_os = "ios/com.soundhealer";

final config = configs[config_current_os];

final Map<String, dynamic> menu = config["menu"];
final Map<String, dynamic> defaults = config["defaults"];

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
