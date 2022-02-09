//import 'package:soundhealer/config/oscillators.dart';


import '/config/app.dart';

const config_app_vl = {
  "title": "SoundHealer",
  "description": "Vladimir Edition",
  "build": "(build 1002)",
  
  "defaults": defaults_app_vl,
  "forces": forces_app_vl,

  "pages": {
    "programs": ["program"],
    //"targets": ["target"],
    //"modulations": ["modulation"],
  },
  "select": {
    "program": programs_app_vl,
    "target": targets_app_vl,
    "modulation": modulations_app_vl,
    "enviroment": enviroments_app,
    "audio": audios_app,
    "multi": multis_app,
    "oscillator": oscillators_app,
    "angle": angles_app,    
  },
  "visible":{
    "search": true,
    "description": true,
    "build": true,
    "select": {
      "program": true,
      "target": true,
      "modulation": true,
    },
  }
};

const config_app_dev = {
  "title": "SoundHealer DEV",
  "defaults": defaults_app_dev,
  "pages": {
    "home": [],
    "programs": ["program"],
    "mantras": [],
    "af": [],
    "rf": [],
    "targets": ["target", "enviroment"],
    "modulations": ["multi", "modulation"],
    "devices": ["oscillator"],
    "d3d": [],
    "imask": [],
    "settings": ["angle"],
  },
  "select": {
    "program": programs_app_dev,
    "target": targets_app_dev,
    "enviroment": enviroments_app,
    "modulation": modulations_app,
    "multi": multis_app,
    "oscillator": oscillators_app,
    "angle": angles_app,
  },
  "search": true,
};

const config_app_pro = {
  "title": "SoundHealer PRO",
  "defaults": defaults_app_pro,
  "pages": {
    //"programs": ["program"],
    "targets": ["target", "enviroment"],
    "modulations": ["multi", "modulation"],
    //"devices": ["oscillator"],
    "settings": ["angle"],
  },
  "select": {
    "program": programs_app_pro,
    "target": targets_app_pro,
    "enviroment": enviroments_app,
    "modulation": modulations_app,
    "multi": multis_app,
    "audio": audios_app,
    "channel": channels_app,
    "angle": angles_app
  },
  "search": false,
};

const config_app_lite = {
  "title": "SoundHealer",
  "defaults": defaults_app_lite,
  "pages": {
    "targets": ["target"],
    "settings": ["angle"],
  },
  "select": {
    "program": programs_app_lite,
    "target": targets_app_lite,
    "angle": angles_app,
  },
  "search": false,
};

const Map<String, dynamic> configs = {
  "android/com.soundhealer": config_app_lite,
  "ios/com.soundhealer": config_app_lite,
  "android/com.soundhealer.pro": config_app_pro,
  "ios/com.soundhealer.pro": config_app_pro,
  "android/com.soundhealer.dev": config_app_dev,
  "ios/com.soundhealer.dev": config_app_dev,
  "android/com.soundhealer.vl": config_app_vl,
  //"yl.soundhealer.com": {"title": "SoundHealer Young Living Edition"}
};
