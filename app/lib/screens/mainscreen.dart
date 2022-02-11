import 'package:flutter/material.dart';

import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:volume_control/volume_control.dart';

// https://docs.flutter.dev/development/accessibility-and-localization/internationalization
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:io' show Platform;
import 'dart:async';

import '/globals.dart' as globals;

import '/components/appbar.dart';
import '/components/mainbody.dart';
import '/components/bottom.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  Timer? _timer;

  void getUserSetting(item) async {
    var prefs_key = globals.prefs?.getString(item);
    var default_key = globals.defaultSettings[item];

    if (prefs_key != null) if (globals.select[item][prefs_key] == null) prefs_key = null;
    if (default_key != null) if (globals.select[item][default_key] == null) default_key = null;

    globals.selected[item] = prefs_key ?? default_key;
    globals.selected[item] ??= globals.select[item].keys.toList()[0];
  }

  void getUserSettings() async {
    if (globals.prefs == null) {
      globals.prefs = await SharedPreferences.getInstance();
    }
    getUserSetting("category");
    getUserSetting("folder");
    getUserSetting("program");
    getUserSetting("angle");
    getUserSetting("enviroment");
    getUserSetting("modulation");
    getUserSetting("multi");
    getUserSetting("target");
    getUserSetting("oscillator");
    getUserSetting("audio");
  }

  void saveUserSettingInt(item) async {
    await globals.prefs?.setInt(item, globals.selected[item]);
  }

  void saveUserSettingDouble(item) async {
    await globals.prefs?.setDouble(item, globals.selected[item]);
  }

  void saveUserSettingString(item) async {
    await globals.prefs?.setString(item, globals.selected[item]);
  }

  void saveUserSettings() async {
    if (globals.prefs == null) {
      globals.prefs = await SharedPreferences.getInstance();
    }
    saveUserSettingString("angle");
    saveUserSettingString("modulation");
    saveUserSettingString("multi");
    saveUserSettingString("program");
    saveUserSettingString("oscillator");
    saveUserSettingString("target");
    saveUserSettingString("enviroment");
  }

  void setParams() {
    print("setParams() names=");
    print(globals.selected);
    print(globals.select["program"][globals.selected["program"]]);

    globals.frequency = (globals.config["forces"]["target"] ?? globals.select["target"][globals.selected["target"]]).toDouble();

    //print(globals.isIOS);

    if (globals.isIOS) {
      SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
    } else {
      SoundGenerator.setWaveType(waveTypes.MULTI);
      SoundGenerator.setParams(
          globals.config["forces"]["program"] ?? globals.select["program"][globals.selected["program"]],
          (globals.config["forces"]["target"] ?? globals.select["target"][globals.selected["target"]]).toDouble(),
          (globals.config["forces"]["enviroment"] ?? globals.select["enviroment"][globals.selected["enviroment"]]).toDouble(),
          (globals.config["forces"]["modulation"] ?? globals.select["modulation"][globals.selected["modulation"]]).toDouble(),
          (globals.config["forces"]["multi"] ?? globals.select["multi"][globals.selected["multi"]]).toDouble(),
          (globals.config["forces"]["angle"] ?? globals.select["angle"][globals.selected["angle"]]).toDouble(),
          (globals.config["forces"]["oscillator"] ?? globals.select["oscillator"][globals.selected["oscillator"]]).toDouble());

      print("123");
    }

    SoundGenerator.setFrequency(globals.frequency);
  }

  void play() {
    globals.setState(() {
      globals.isPlaying = !globals.isPlaying;
      if (globals.isPlaying) {
        globals.setParams();
        SoundGenerator.play();
      } else {
        SoundGenerator.stop();
        globals.frequency = 0;
      }
    });

    if (globals.isPlaying) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        double fr = await SoundGenerator.getFrequency;
        globals.setState(() {
          globals.frequency = fr;
        });
      });
    } else {
      globals.setState(() {
        _timer?.cancel();
        _timer = null;
        globals.frequency = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // TODO: FIX:
    globals.setState = setState;
    globals.setParams = setParams;

    globals.play = play;

    getUserSettings();

    if (globals.isIOS) {
      SoundGenerator.init(48000);
      SoundGenerator.setWaveType(waveTypes.SINUSOIDAL); //Для iOS, пока не реализован multi
    } else {
      SoundGenerator.init(48000);
      //SoundGenerator.init(96000);
      //SoundGenerator.init(96000, 4, 2); //Позже добавить многоканальные
      SoundGenerator.setWaveType(waveTypes.MULTI);
      print("555");
    }

    VolumeControl.setVolume(1);
    SoundGenerator.setVolume(1);

    /*
    SoundGenerator.onFrequencyChanged.listen((value) {
      globals.setState(() {
        globals.frequency  = value;
      });
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    globals.AppLocalizations = AppLocalizations;
    globals.AppLocalizationsOC = AppLocalizations.of(context);

    return Scaffold(
        appBar: mainAppBar(context),
        bottomNavigationBar: myBottomNavigationBar(context),
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              Color.fromRGBO(12, 232, 92, 1.0),
              Color.fromRGBO(7, 117, 229, 1.0),
            ])),
            child: mainBody(context)));
  }
}
