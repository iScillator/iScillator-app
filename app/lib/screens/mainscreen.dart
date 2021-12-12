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
  void getUserSettings() async {
    if (globals.prefs == null) {
      globals.prefs = await SharedPreferences.getInstance();
    }
    globals.userSettings["folder"] =
        globals.prefs?.getInt('folder') ?? globals.defaultSettings["folder"];
    globals.userSettings["program"] =
        globals.prefs?.getInt('program') ?? globals.defaultSettings["program"];
    globals.userSettings["angle"] =
        globals.prefs?.getInt('angle') ?? globals.defaultSettings["angle"];
    globals.userSettings["enviroment"] =
        globals.prefs?.getDouble('enviroment') ??
            globals.defaultSettings["enviroment"];
    globals.userSettings["modulation"] = globals.prefs?.getInt('modulation') ??
        globals.defaultSettings["modulation"];
    globals.userSettings["multi"] =
        globals.prefs?.getInt('multi') ?? globals.defaultSettings["multi"];
    globals.userSettings["target"] =
        globals.prefs?.getDouble('target') ?? globals.defaultSettings["target"];
    globals.userSettings["audioDevice"] =
        globals.prefs?.getInt('audioDevice') ??
            globals.defaultSettings["audioDevice"];
  }

  void getSelected() async {
    globals.selected["audioDevices"] = globals.menu_rev["audioDevices"].keys
        .toList()
        .indexOf(globals.userSettings["audioDevices"]);
    globals.selected["enviroment"] = globals.menu_rev["enviroments"].keys
        .toList()
        .indexOf(globals.userSettings["program"]);
    globals.selected["modulation"] = globals.menu_rev["modulations"].keys
        .toList()
        .indexOf(globals.userSettings["modulation"]);
    globals.selected["multi"] = globals.menu_rev["multis"].keys
        .toList()
        .indexOf(globals.userSettings["multi"]);
    globals.selected["target"] = globals.menu_rev["targets"].keys
        .toList()
        .indexOf(globals.userSettings["target"]);
    globals.selected["angle"] = globals.menu_rev["angles"].keys
        .toList()
        .indexOf(globals.userSettings["angle"]);
    globals.selected["audioDevice"] = globals.menu_rev["audioDevices"].keys
        .toList()
        .indexOf(globals.userSettings["audioDevice"]);
    //print(globals.selected);
  }

  void saveUserSettings() async {
    if (globals.prefs == null) {
      globals.prefs = await SharedPreferences.getInstance();
    }
    await globals.prefs?.setInt('folder', globals.userSettings["folder"]);
    await globals.prefs?.setInt('program', globals.userSettings["program"]);
    await globals.prefs?.setInt('angle', globals.userSettings["angle"]);
    await globals.prefs
        ?.setDouble('enviroment', globals.userSettings["enviroment"]);
    await globals.prefs
        ?.setInt('modulation', globals.userSettings["modulation"]);
    await globals.prefs?.setInt('multi', globals.userSettings["multi"]);
    await globals.prefs?.setDouble('target', globals.userSettings["target"]);
    await globals.prefs
        ?.setInt('audioDevice', globals.userSettings["audioDevice"]);
  }

  void setParams() {
    globals.frequency = globals.userSettings["target"].toDouble();
    // TODO: FIX:
    globals.sg = SoundGenerator;

    globals.userSettings["target"] =
        globals.menu["target"].values.toList()[globals.selected["target"]];
    globals.userSettings["enviroment"] = globals.menu["enviroment"].values
        .toList()[globals.selected["enviroment"]];
    globals.userSettings["modulation"] = globals.menu["modulation"].values
        .toList()[globals.selected["modulation"]];
    globals.userSettings["multi"] =
        globals.menu["multi"].values.toList()[globals.selected["multi"]];
    globals.userSettings["channel"] =
        globals.menu["channel"].values.toList()[globals.selected["channel"]];
    globals.userSettings["audio"] =
        globals.menu["audio"].values.toList()[globals.selected["audio"]];
    globals.userSettings["angle"] =
        globals.menu["angle"].values.toList()[globals.selected["angle"]];

    if (Platform.isIOS) {
      SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
    } else {
      SoundGenerator.setWaveType(waveTypes.MULTI);
      SoundGenerator.setParams(
          globals.userSettings["target"].toDouble(),
          globals.userSettings["enviroment"].toDouble(),
          globals.userSettings["modulation"].toDouble(),
          globals.userSettings["multi"].toDouble(),
          globals.userSettings["channel"].toDouble(),
          globals.userSettings["audio"].toDouble());
    }

    SoundGenerator.setFrequency(globals.frequency);
  }

  @override
  void initState() {
    super.initState();

    // TODO: FIX:
    globals.sg = SoundGenerator;
    globals.setState = setState;
    globals.setParams = setParams;
    globals.SoundGenerator1 = SoundGenerator;

    getUserSettings();
    getSelected();

    if (Platform.isIOS) {
      SoundGenerator.init(48000);
      SoundGenerator.setWaveType(
          waveTypes.SINUSOIDAL); //Для iOS, пока не реализован multi
    } else {
      SoundGenerator.init(96000);
      //sg.init(96000, 4, 2); //Позже добавить многоканальные
      SoundGenerator.setWaveType(waveTypes.MULTI);
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
