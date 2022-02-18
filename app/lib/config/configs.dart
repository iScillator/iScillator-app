//import 'package:soundhealer/config/oscillators.dart';

import 'package:flutter/material.dart';

import '/config/app.dart';

const config_app_vl = {
  "title": "FrequencyHealer",
  "description": "Frequency Edition",
  "defaults": defaults_app_vl,
  "forces": forces_app_vl,
  "pages": {
    "programs": ["categories","folders","program"],
  },
  "select": {
    "program": programs_app_vl,
    "folder": folders_app,
    "category": categories_app,
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
    "description": false,
    "build": true,
  },
  "gradient": LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
              Color.fromARGB(255, 232, 173, 12),
              Color.fromARGB(255, 22, 82, 141),
            ]),
  "gradient2": LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
              Color.fromARGB(255, 232, 173, 12),
              Color.fromARGB(255, 22, 82, 141),
                        ]),
};

const config_app_dev = {
  "title": "SoundHealer DEV",
  "description": "Development Edition",
  "defaults": defaults_app_dev,
  "forces": forces_app_dev,
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
  "visible":{
    "search": true,
    "description": true,
    "build": true,
  }
};

const config_app_pro = {
  "title": "SoundHealer PRO",
  "description": "PRO Edition",
  "defaults": defaults_app_pro,
  "forces": forces_app_pro,
  "pages": {
    "programs": ["category","folder","program"],
    "targets": ["target", "enviroment"],
    "modulations": ["multi", "modulation","waveform"],
    "devices": ["oscillator","emmiter"],
    "settings": ["audio","angle"],
  },
  "select": {
    "folder": folders_app,
    "category": categories_app,
    "program": programs_app_pro,
    "target": targets_app_pro,
    "enviroment": enviroments_app,
    "modulation": modulations_app,
    "multi": multis_app,
    "audio": audios_app,
    "channel": channels_app,
    "angle": angles_app,
    "oscillator": oscillators_app,
    "emmiter": emmiters_app,
  },
  "visible":{
    "search": true,
    "description": false,
    "build": true,
  },
  "gradient": LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              Color.fromRGBO(12, 232, 92, 1.0),
              Color.fromRGBO(7, 117, 229, 1.0),
            ]),
  "gradient2":LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(7, 117, 229, 1.0),
                          Color.fromRGBO(12, 232, 92, 1.0),
                        ])

};

const config_app_lite = {
  "title": "SoundHealer",
  "description": "Lite Edition",
  "defaults": defaults_app_lite,
  "forces": forces_app_lite,
  "pages": {
    "programs": ["categories","program"],
  },
  "select": {
    "program": programs_app_lite,
    "target": targets_app_lite,
    "modulation": modulations_app,
    "enviroment": enviroments_app,
    "audio": audios_app,
    "multi": multis_app,
    "oscillator": oscillators_app,
    "angle": angles_app,    
  },
  "visible":{
    "search": true,
    "description": false,
    "build": false,
  },
  "gradient": LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
              Color.fromARGB(255, 232, 173, 12),
              Color.fromARGB(255, 22, 82, 141),
            ]),
  "gradient2": LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
              Color.fromARGB(255, 232, 173, 12),
              Color.fromARGB(255, 22, 82, 141),
                        ]),
};

const Map<String, dynamic> configs = {
  "android/com.soundhealer": config_app_lite,
  "ios/com.soundhealer": config_app_lite,
  "android/com.soundhealer.pro": config_app_pro,
  "ios/com.soundhealer.pro": config_app_pro,
  "android/com.soundhealer.dev": config_app_dev,
  "ios/com.soundhealer.dev": config_app_dev,
  "android/com.frequencyhealer": config_app_vl,
  //"yl.soundhealer.com": {"title": "SoundHealer Young Living Edition"}
};
