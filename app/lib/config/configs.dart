import 'targets.dart';
import 'audios.dart';
import 'channels.dart';
import 'enviroments.dart';
import 'modulations.dart';
import 'multis.dart';

const Map<String, dynamic> configs = {
  "soundhealer.com": {
    "title": "SoundHealer",
    "default": {
      "audio": 0,
      "channel": 120,
      "enviroment": 0,
      "modulation": 1024,
      "multi": 3,
      "target": 528
    },
    "menu": {
      "targets": targets_lite,
      "enviroments": enviroments,
      "modulations": modulations,
      "multis": multis,
      "audios": audios,
      "channels": channels
    }
  },
  "pro.soundhealer.com": {
    "title": "SoundHealer PRO",
    "default": {
      "audio": 0,
      "channel": 120,
      "enviroment": 0,
      "modulation": 1024,
      "multi": 3,
      "target": 528
    },
    "menu": {
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

const config_current = "soundhealer.com";
final config = configs[config_current];
