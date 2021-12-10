import '/config/audios.dart';
import '/config/channels.dart';
import '/config/enviroments.dart';
import '/config/modulations.dart';
import '/config/multis.dart';
import '/config/targets.dart';
import '/config/folders.dart';

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
  "android/com.soundhealer.dev": {
    "title": "SoundHealer DEV",
    "defaults": defaults_dev,
    "menu": {
      "programs": programs_dev,
      "targets": targets_dev,
      "enviroments": enviroments,
      "modulations": modulations,
      "multis": multis,
      "audios": audios,
      "channels": channels
    },
  },
  "yl.soundhealer.com": {"title": "SoundHealer Young Living Edition"}
};
