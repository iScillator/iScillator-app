const Map<String, dynamic> defaults_app_dev = {
  "angle": 0,
  "enviroment": 0,
  "modulation": 10025,
  "multi": 0,
  "target": 10000,
  "program": 0,
  "oscillator": 0
};

const Map<String, dynamic> defaults_app_vl = {
/*
  "angle": 0,
  "enviroment": 0,
  "modulation": 10025,
  "multi": 0,
  "target": 10000,
  "program": "{'autonext':'60','target':[10000, 5000, 3176, 2720, 2489, 2189, 2184, 2128, 2084, 2050, 2008, 880, 854, 800, 784, 728, 666, 524, 464, 333, 304]}",
  "oscillator": 0
*/

  "angle": "Stereo 0°",
  "enviroment": "None",
  "modulation": "Sinus",
  "multi": "Fix x",
  "target": "10 kHz",
  "program": "Coronavirus SARS",
  "oscillator": "Internal"

};

const defaults_app_pro = defaults_app_dev;
const defaults_app_lite = defaults_app_dev;

const Map<String, dynamic> defaults_fix = {
  "angle": 0,
  "enviroment": 0,
  "modulation": 0,
  "multi": 0,
};

const defaults_essentials = defaults_fix;

const Map<String, dynamic> defaults_bills_golden = {
  "angle": 0,
  "enviroment": 0,
  "modulation": 0,
  "multi": -3,
};

const Map<String, dynamic> defaults_bills_square = {
  "angle": 0,
  "enviroment": 0,
  "modulation": 0,
  "multi": -2,
};

const Map<String, dynamic> defaults_bills_binaural = {
  "angle": 1,
  "enviroment": 0,
  "modulation": 0,
  "multi": -3,
};

const Map<String, dynamic> defaults_rife_audio = {
  "audio": 0,
  "angle": 120,
  "enviroment": 0,
  "modulation": 0,
  "multi": 0,
};

const Map<String, dynamic> defaults_rife_radio_to_sound = {
  "audio": 0,
  "channel": 120,
  "enviroment": 0,
  "modulation": 10241,
  "multi": 3,
};

const Map<String, dynamic> defaults_rife_radio = {
  "angle": 0,
  "enviroment": 0,
  "modulation": 0,
  "multi": 0,
};
