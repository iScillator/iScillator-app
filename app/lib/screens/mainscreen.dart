import 'package:flutter/material.dart';

import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

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
  void getUserSetting(item) async {
    globals.userSettings[item] =
        globals.prefs?.getInt(item) ?? globals.defaultSettings[item];
  }

  void getUserSettings() async {
    if (globals.prefs == null) {
      globals.prefs = await SharedPreferences.getInstance();
    }
    getUserSetting("program");
    getUserSetting("angle");
    getUserSetting("enviroment");
    getUserSetting("modulation");
    getUserSetting("multi");
    getUserSetting("target");
    getUserSetting("oscillator");
  }

  void getSelectedItem(item) async {
    globals.selected[item] = globals.select_rev[item].keys
        .toList()
        .indexOf(globals.userSettings[item]);
  }

  void getSelected() async {
    getSelectedItem("oscillator");
    getSelectedItem("enviroment");
    getSelectedItem("modulation");
    getSelectedItem("multi");
    getSelectedItem("target");
    getSelectedItem("angle");
    //print(globals.selected);
  }

  void saveUserSettingInt(item) async {
    await globals.prefs?.setInt(item, globals.userSettings[item]);
  }

  void saveUserSettingDouble(item) async {
    await globals.prefs?.setDouble(item, globals.userSettings[item]);
  }

  void saveUserSettings() async {
    if (globals.prefs == null) {
      globals.prefs = await SharedPreferences.getInstance();
    }
    saveUserSettingInt("angle");
    saveUserSettingInt("modulation");
    saveUserSettingInt("multi");
    saveUserSettingInt("program");
    saveUserSettingInt("oscillator");
    saveUserSettingDouble("target");
    saveUserSettingDouble("enviroment");
  }

/*
  void setParam(item) {
    if (globals.selected[item])
      globals.userSettings[item] =
          globals.select[item].values.toList()[globals.selected[item]];
  }
*/

  void selectParam(item) {
    //if (globals.selected[item])
    globals.userSettings[item] =
        globals.select[item].values.toList()[globals.selected[item]];

    print(globals.userSettings);
  }

  void setParams() {
    /*
    setParam("target");
    setParam("enviroment");
    setParam("modulation");
    setParam("multi");
    setParam("oscillator");
    setParam("angle");
    */
    print(globals.userSettings);

    globals.frequency = globals.userSettings["target"].toDouble();

    print(Platform.isIOS);

    if (Platform.isIOS) {
      SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
    } else {
      SoundGenerator.setWaveType(waveTypes.MULTI);
      SoundGenerator.setParams(
          globals.userSettings["target"].toDouble(),
          globals.userSettings["enviroment"].toDouble(),
          globals.userSettings["modulation"].toDouble(),
          globals.userSettings["multi"].toDouble(),
          globals.userSettings["angle"].toDouble(),
          globals.userSettings["oscillator"].toDouble());

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
  }

  @override
  void initState() {
    super.initState();

    // TODO: FIX:
    globals.setState = setState;
    globals.setParams = setParams;
    globals.selectParam = selectParam;
    globals.play = play;

    getUserSettings();
    getSelected();

    if (Platform.isIOS) {
      SoundGenerator.init(48000);
      SoundGenerator.setWaveType(
          waveTypes.SINUSOIDAL); //Для iOS, пока не реализован multi
    } else {
      SoundGenerator.init(96000);
      //SoundGenerator.init(96000, 4, 2); //Позже добавить многоканальные
      SoundGenerator.setWaveType(waveTypes.MULTI);
      print("555");
    }

    SoundGenerator.setVolume(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context),
        bottomNavigationBar: myBottomNavigationBar(context),
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromRGBO(12, 232, 92, 1.0),
                  Color.fromRGBO(7, 117, 229, 1.0),
                ])),
            child: mainBody(context)));
  }
}
