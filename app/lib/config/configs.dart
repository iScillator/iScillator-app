import 'package:soundhealer/config/oscillators.dart';

import '/config/audios.dart';
import '/config/channels.dart';
import '/config/enviroments.dart';
import '/config/modulations.dart';
import '/config/multis.dart';
import '/config/targets.dart';
import '/config/programs.dart';
import '/config/angles.dart';
import '/config/defaults.dart';

const config_app_dev = {
  "title": "SoundHealer DEV",
  "defaults": defaults_app_dev,
  "pages": {
    "programs": ["program"],
    "targets": ["target", "enviroment"],
    "modulations": ["multi", "modulation"],
    "devices": ["oscillator"],
    "settings": ["angle"],
  },
  "select": {
    "program": programs_app_dev,
    "target": targets_app_dev,
    "enviroment": enviroments,
    "modulation": modulations,
    "multi": multis,
    "oscillator": oscillators,
    "angle": angles,
  },
};

const config_app_pro = {
  "title": "SoundHealer PRO",
  "defaults": defaults_app_pro,
  "select": {
    "program": programs_app_pro,
    "target": targets_app_pro,
    "enviroment": enviroments,
    "modulation": modulations,
    "multi": multis,
    "audio": audioDevices,
    "channel": channels
  }
};

const config_app_lite = {
  "title": "SoundHealer",
  "defaults": defaults_app_lite,
  "pages": {
    "programs": ["program"],
    "settings": ["angle"],
  },
  "select": {
    "program": programs_app_lite,
    "target": targets_app_lite,
  },
};

const Map<String, dynamic> configs = {
  "android/com.soundhealer": config_app_lite,
  "ios/com.soundhealer": config_app_lite,
  "android/com.soundhealer.pro": config_app_pro,
  "ios/com.soundhealer.pro": config_app_pro,
  "android/com.soundhealer.dev": config_app_dev,
  "ios/com.soundhealer.dev": config_app_dev,
  "yl.soundhealer.com": {"title": "SoundHealer Young Living Edition"}
};
