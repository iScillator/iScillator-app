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

const Map<String, dynamic> configs = {
  "android/com.soundhealer": {
    "title": "SoundHealer",
    "defaults": defaults_app_lite,
    "select": {
      "program": programs_app_lite,
      "target": targets_app_lite,
    }
  },
  "ios/com.soundhealer": {
    "title": "SoundHealer",
    "defaults": defaults_app_lite,
    "select": {
      "program": programs_app_lite,
      "target": targets_app_lite,
    }
  },
  "android/com.soundhealer.pro": {
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
  },
  "android/com.soundhealer.dev": {
    "title": "SoundHealer DEV",
    "defaults": defaults_app_dev,
    "pages": {
      "programs": ["program"],
      "targets": ["target", "enviroment"],
      "modulations": ["multi", "modulation"],
      "devices": ["oscillator"],
      "settings": ["angle"],
    },
    //TODO: rename to selects
    "select": {
      "program": programs_app_dev,
      "target": targets_app_dev,
      "enviroment": enviroments,
      "modulation": modulations,
      "multi": multis,
      "oscillator": oscillators,
      "angle": angles,
    },
  },
  "yl.soundhealer.com": {"title": "SoundHealer Young Living Edition"}
};
