library my_prj.globals;

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

import '/models/user_settings.dart';
import '/config/configs.dart';
import '/config/current/current.dart';

var play;
var setState;
var setParams;
var selectParam;

var pageController;
var showWindow;
var t;

SharedPreferences? prefs;

final Map<String, dynamic> defaults = config["defaults"];
final defaultSettings = defaults;

final Map<String, dynamic> userSettings = {
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

final isIOS = (isIOS_change ? isIOS_current : Platform.isIOS);

final config_current_os = (isIOS ? "ios/" : "android/") + config_current;

//final config_current_os = "ios/com.soundhealer.pro";

final config = configs[config_current_os];

final Map<String, dynamic> select = config["select"];
final Map<String, dynamic> pages = config["pages"];

final Map<String, dynamic> select_rev = {
  "angle": (select["angle"] != null
      ? select["angle"].map((k, v) => MapEntry(v, k))
      : {}),
  "program": (select["program"] != null
      ? select["program"].map((k, v) => MapEntry(v, k))
      : {}),
  "oscillator": (select["oscillator"] != null
      ? select["oscillator"].map((k, v) => MapEntry(v, k))
      : {}),
  "enviroment": (select["enviroment"] != null
      ? select["enviroment"].map((k, v) => MapEntry(v, k))
      : {}),
  "modulation": (select["modulation"] != null
      ? select["modulation"].map((k, v) => MapEntry(v, k))
      : {}),
  "multi": (select["multi"] != null
      ? select["multi"].map((k, v) => MapEntry(v, k))
      : {}),
  "target": (select["target"] != null
      ? select["target"].map((k, v) => MapEntry(v, k))
      : {}),
};

final selected = {
  "angle": select_rev["angle"].keys.toList().indexOf(userSettings["angle"]),
  "oscillator": select_rev["oscillator"]
      .keys
      .toList()
      .indexOf(userSettings["oscillator"]),
  "program":
      select_rev["program"].keys.toList().indexOf(userSettings["program"]),
  "enviroment": select_rev["enviroment"]
      .keys
      .toList()
      .indexOf(userSettings["enviroment"]),
  "modulation": select_rev["modulation"]
      .keys
      .toList()
      .indexOf(userSettings["modulation"]),
  "multi": select_rev["multi"].keys.toList().indexOf(userSettings["multi"]),
  "target": select_rev["target"].keys.toList().indexOf(userSettings["target"]),
};

final isWindowShown = {
  "program": false,
  "angle": false,
  "oscillator": false,
  "enviroment": false,
  "modulation": false,
  "multi": false,
  "target": false,
};

var isSearchShown=false;
var SearchText="";
//var filteredItems;
var filteredItems=select["program"].keys.toList();