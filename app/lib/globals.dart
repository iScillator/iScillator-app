library my_prj.globals;

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

import '/config/configs.dart';
import '/config/current/current.dart';
import '/modules/l108.dart' as l108;

var play;
var setState;
var setParams;

var pageController;
var showWindow;

//var t;

const l108o=l108.l108o;
const l108t=l108.l108t;

var mainContext;
var AppLocalizations;


SharedPreferences? prefs;

final Map<String, dynamic> defaults = config["defaults"];
final defaultSettings = defaults;

final Map<String, dynamic> selected = {
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

var filteredItems={
  //"angle":(select["angle"] != null ? select["angle"].keys.toList():[]),
  "angle":(select["angle"]?? {}),
  "oscillator":(select["oscillator"] ?? {}),
  "program":(select["program"] ?? {}),
  "enviroment":(select["enviroment"] ?? {}),
  "modulation":(select["modulation"] ?? {}),
  "multi":(select["multi"] ?? {}),
  "target":(select["target"] ?? {})
};

