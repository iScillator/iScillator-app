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
    "defaults": defaults_fix, //DEPRECEATED
    "menu": {
      "programs": programs_app_lite,
      "targets": targets_app_lite,
    }
  },
  "ios/com.soundhealer": {
    "title": "SoundHealer",
    "defaults": defaults_fix, //DEPRECEATED
    "menu": {
      "programs": programs_app_lite,
      "targets": targets_app_lite,
    }
  },
  "android/com.soundhealer.pro": {
    "title": "SoundHealer PRO",
    "defaults": defaults_fix, //DEPRECEATED
    "menu": {
      "programs": programs_app_pro,
      "targets": targets_app_pro,
      "enviroments": enviroments,
      "modulations": modulations,
      "multis": multis,
      "audios": audioDevices,
      "channels": channels
    }
  },
  "android/com.soundhealer.dev": {
    "title": "SoundHealer DEV",
    "defaults": defaults_fix, //DEPRECEATED
    "pages": {
      "programs": ["programs"],
      "targets": ["targets", "enviroments"],
      "modulations": ["multis", "modulations"],
      "devices": ["audioDevices"],
      "settings": ["angles"],
    },
    //TODO: rename to selects
    "menu": {
      "programs": programs_app_dev,
      "targets": targets_app_dev,
      "enviroments": enviroments,
      "modulations": modulations,
      "multis": multis,
      "audioDevices": audioDevices,
      "angles": angles,
    },
  },
  "yl.soundhealer.com": {"title": "SoundHealer Young Living Edition"}
};
