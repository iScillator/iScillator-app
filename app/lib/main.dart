// iOS issues resolving:
// 1. Set AudioKit version in sound_generator.podspecs to: s.dependency 'AudioKit', '~> 4.11.1'
// 2. Set minimum iOS version in podfil to 13
// 3. Do the following changes in public init(registrar: FlutterPluginRegistrar) method implementation in SwiftSoundGeneratorPlugin:
//    ...
//    let messenger = (registrar as? NSObject)?.value(forKey: "messenger")
//      if messenger == nil {
//              return
//          }
//    let methodChannel = FlutterMethodChannel(name: "sound_generator", binaryMessenger: messenger as! FlutterBinaryMessenger)
//    self.onChangeIsPlaying = BetterEventChannel(name: "io.github.mertguner.sound_generator/onChangeIsPlaying", messenger: messenger as! FlutterBinaryMessenger)
//    self.onOneCycleDataHandler = BetterEventChannel(name: "io.github.mertguner.sound_generator/onOneCycleDataHandler", messenger: messenger as! FlutterBinaryMessenger)

// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/settings.dart';
import 'models/user_settings.dart';

import 'config/configs.dart';

import 'config/audios.dart';
import 'config/channels.dart';
import 'config/enviroments.dart';
import 'config/modulations.dart';
import 'config/multis.dart';
import 'config/targets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  bool _isPlaying = false;

  //bool _isPresetWindowShown = false;
  bool _isPresetWindowAudiosShown = false;
  bool _isPresetWindowChannelsShown = false;
  bool _isPresetWindowEnviromentsShown = false;
  bool _isPresetWindowModulationsShown = false;
  bool _isPresetWindowMultisShown = false;
  bool _isPresetWindowTargetsShown = false;

  /*
  int _selectedSound = 0;
  */

  int _selectedAudio = 0;
  int _selectedChannel = 1; // 60;
  int _selectedEnviroment = 0;
  int _selectedModulation = 1; //1024;
  int _selectedMulti = 2; //3;
  int _selectedTarget = 3; //528;

  double _frequency = 0;

  Timer? _timer;

  SharedPreferences? prefs;
  UserSettings? userSettings;

  @override
  void initState() {
    super.initState();

    _getSettings().then((settings) {
      userSettings = settings;

      waveTypes _waveType = waveTypes.SINUSOIDAL;
      if (userSettings?.waveType == 1) _waveType = waveTypes.SQUAREWAVE;
      if (userSettings?.waveType == 2) _waveType = waveTypes.TRIANGLE;
      if (userSettings?.waveType == 3) _waveType = waveTypes.SAWTOOTH;
      //if (userSettings?.waveType == 4) _waveType = waveTypes.MULTI;
      //if (userSettings?.waveType == 5) _waveType = waveTypes.MULTI;

      SoundGenerator.init(48000);
      //SoundGenerator.init(96000, 4, 2);

      SoundGenerator.setWaveType(_waveType);
      SoundGenerator.setBalance(userSettings?.balance ?? 0.0);
      SoundGenerator.setVolume(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget frequencySection = Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Text('${_frequency.toInt()} Hz',
            style: TextStyle(color: Colors.white70, fontSize: 60.0)),
        Positioned(
          child: Text('Frequency',
              style: TextStyle(color: Colors.white70, fontSize: 20.0)),
          top: 65.0,
        )
      ],
    );

    return Scaffold(
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            SafeArea(
                child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(top: 20.0), child: frequencySection),
              Expanded(child: PlayButton(onPlayingChange: _play)),

              ///!!!
              /*
              SelectPresetButton(
                presetName: targets.keys.toList()[_selectedSound],
                tapMethod: _showPresetWindow,
              ),
              Divider(
                indent: 60,
                endIndent: 60,
                color: Colors.white,
              ),*/
              SelectPresetButton(
                presetName: targets.keys.toList()[_selectedTarget],
                tapMethod: _showPresetWindowTargets,
              ),
              Divider(
                indent: 60,
                endIndent: 60,
                color: Colors.white,
              ),
              SelectPresetButton(
                presetName: enviroments.keys.toList()[_selectedEnviroment],
                tapMethod: _showPresetWindowEnviroments,
              ),
              Divider(
                indent: 60,
                endIndent: 60,
                color: Colors.white,
              ),
              SelectPresetButton(
                presetName: modulations.keys.toList()[_selectedModulation],
                tapMethod: _showPresetWindowModulations,
              ),
              Divider(
                indent: 60,
                endIndent: 60,
                color: Colors.white,
              ),
              SelectPresetButton(
                presetName: multis.keys.toList()[_selectedMulti],
                tapMethod: _showPresetWindowMultis,
              ),
              Divider(
                indent: 60,
                endIndent: 60,
                color: Colors.white,
              ),
              SelectPresetButton(
                presetName: channels.keys.toList()[_selectedChannel],
                tapMethod: _showPresetWindowChannels,
              ),
              Divider(
                indent: 60,
                endIndent: 60,
                color: Colors.white,
              ),
              SelectPresetButton(
                presetName: audios.keys.toList()[_selectedAudio],
                tapMethod: _showPresetWindowAudios,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0, top: 40.0),
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen(
                                    userSettings: userSettings,
                                    prefs: prefs,
                                  )));
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 20,
                    ),
                    label: Text('Settings'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    )),
              )
            ])),
            /*
            if (_isPresetWindowShown)
              PresetWindow(
                selectSound: _selectSound,
                selectedSound: _selectedSound,
              ),
            */
            if (_isPresetWindowAudiosShown)
              PresetWindow(
                items: audios,
                selectItem: _selectAudio,
                selectedItem: _selectedAudio,
              ),
            if (_isPresetWindowChannelsShown)
              PresetWindow(
                items: channels,
                selectItem: _selectChannel,
                selectedItem: _selectedChannel,
              ),
            if (_isPresetWindowEnviromentsShown)
              PresetWindow(
                items: enviroments,
                selectItem: _selectEnviroment,
                selectedItem: _selectedEnviroment,
              ),
            if (_isPresetWindowModulationsShown)
              PresetWindow(
                items: modulations,
                selectItem: _selectModulation,
                selectedItem: _selectedModulation,
              ),
            if (_isPresetWindowMultisShown)
              PresetWindow(
                items: multis,
                selectItem: _selectMulti,
                selectedItem: _selectedMulti,
              ),
            if (_isPresetWindowTargetsShown)
              PresetWindow(
                items: targets,
                selectItem: _selectTarget,
                selectedItem: _selectedTarget,
              )
          ],
        ),
      ),
    );
  }

  void _play() {
    setState(() {
      _isPlaying = !_isPlaying;

      if (_isPlaying) {
        double _presetFrequency = 0;
        _presetFrequency = targets.values.toList()[_selectedTarget].toDouble();

        SoundGenerator.setWaveType(waveTypes.MULTI);
        /*
        if (_selectedModulation.toInt() == 1) {
          SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
        } else {
          SoundGenerator.setWaveType(waveTypes.MULTI);
        }*/

        SoundGenerator.setParams(
            targets.values.toList()[_selectedTarget].toDouble(),
            enviroments.values.toList()[_selectedEnviroment].toDouble(),
            modulations.values.toList()[_selectedModulation].toDouble(),
            multis.values.toList()[_selectedMulti].toDouble(),
            channels.values.toList()[_selectedChannel].toDouble(),
            audios.values.toList()[_selectedAudio].toDouble());

        _frequency = _presetFrequency;
        SoundGenerator.setFrequency(_frequency);

        SoundGenerator.play();

        /*
        _timer = Timer.periodic(Duration(seconds: 2), (timer) {
          setState(() {
            _frequency = _presetFrequency + Random().nextInt(1000);
            SoundGenerator.setFrequency(_frequency);
          });
        });
        */
      } else {
        setState(() {
          _timer?.cancel();
          _timer = null;
          SoundGenerator.stop();
          _frequency = 0;
        });
      }
    });
  }

  // Показ модального окошка выбора
  /*
  void _showPresetWindow() {
    setState(() {
      _isPresetWindowShown = true;
    });
  }
  */

  void _showPresetWindowAudios() {
    setState(() {
      _isPresetWindowAudiosShown = true;
    });
  }

  void _showPresetWindowChannels() {
    setState(() {
      _isPresetWindowChannelsShown = true;
    });
  }

  void _showPresetWindowEnviroments() {
    setState(() {
      _isPresetWindowEnviromentsShown = true;
    });
  }

  void _showPresetWindowModulations() {
    setState(() {
      _isPresetWindowModulationsShown = true;
    });
  }

  void _showPresetWindowMultis() {
    setState(() {
      _isPresetWindowMultisShown = true;
    });
  }

  void _showPresetWindowTargets() {
    setState(() {
      _isPresetWindowTargetsShown = true;
    });
  }

  // Запоминание параметров выбора
/*
  void _selectSound(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowSoundsShown = false;
      } else {
        _selectedSound = num;
        _isPresetWindowSoundsShown = false;
      }
    });
  }
*/

  void _selectAudio(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowAudiosShown = false;
      } else {
        _selectedAudio = num;
        _isPresetWindowAudiosShown = false;
      }
    });
  }

  void _selectChannel(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowChannelsShown = false;
      } else {
        _selectedChannel = num;
        _isPresetWindowChannelsShown = false;
      }
    });
  }

  void _selectEnviroment(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowEnviromentsShown = false;
      } else {
        _selectedEnviroment = num;
        _isPresetWindowEnviromentsShown = false;
      }
    });
  }

  void _selectModulation(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowModulationsShown = false;
      } else {
        _selectedModulation = num;
        _isPresetWindowModulationsShown = false;
      }
    });
  }

  void _selectMulti(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowMultisShown = false;
      } else {
        _selectedMulti = num;
        _isPresetWindowMultisShown = false;
      }
    });
  }

  void _selectTarget(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowTargetsShown = false;
      } else {
        _selectedTarget = num;
        _isPresetWindowTargetsShown = false;
      }
    });
  }

  Future<UserSettings> _getSettings() async {
    prefs = await SharedPreferences.getInstance();
    double? balance = prefs?.getDouble('balance');
    int? waveType = prefs?.getInt('waveType');
    return UserSettings(balance, waveType);
  }
}

class PlayButton extends StatefulWidget {
  const PlayButton({Key? key, required this.onPlayingChange}) : super(key: key);

  final Function onPlayingChange;

  @override
  _PlayButton createState() => _PlayButton();
}

class _PlayButton extends State<PlayButton> {
  bool _highlight = false;
  bool _isPlaying = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    _isPlaying = !_isPlaying;
    widget.onPlayingChange();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTap: _handleTap,
        onTapCancel: _handleTapCancel,
        child: Opacity(
          child: Image.asset(
            !_isPlaying ? 'images/play_button.png' : 'images/pause_button.png',
            height: 120.0,
            width: 120.0,
          ),
          opacity: _highlight ? 0.7 : 1.0,
        ));
  }
}

class SelectPresetButton extends StatefulWidget {
  const SelectPresetButton(
      {Key? key, required this.tapMethod, required this.presetName})
      : super(key: key);

  final Function tapMethod;
  final String presetName;

  @override
  _SelectPresetButton createState() => _SelectPresetButton();
}

class _SelectPresetButton extends State<SelectPresetButton> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.tapMethod();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTap: _handleTap,
        onTapCancel: _handleTapCancel,
        child: Container(
          child: Row(
            children: [
              Expanded(
                  child: Text(widget.presetName,
                      style: TextStyle(
                          fontSize: 19.0,
                          color: _highlight ? Colors.white70 : Colors.white))),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: _highlight ? Colors.white70 : Colors.white,
              ),
            ],
          ),
          width: 300.0,
          height: 45.0,
          padding: EdgeInsets.only(left: 15.0, right: 5.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _highlight ? Colors.white70 : Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ));
  }
}

class PresetWindow extends StatelessWidget {
  const PresetWindow(
      {Key? key,
      required this.items,
      required this.selectItem,
      required this.selectedItem})
      : super(key: key);

  final items;
  final Function selectItem;
  final int selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30, bottom: 30),
        color: Colors.white60,
        child: SafeArea(
            child: Container(
                constraints: BoxConstraints(maxWidth: 350),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(7, 117, 229, 1.0),
                          Color.fromRGBO(12, 232, 92, 1.0),
                        ]),
                    border: Border.all(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          iconSize: 35,
                          onPressed: () {
                            selectItem(-1);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ))),
                  Expanded(
                      child: ListView.builder(
                          itemCount: items.keys.toList().length,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              ListTile(
                                title: Align(
                                    child: Text(
                                      items.keys.toList()[index],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 23.0),
                                    ),
                                    alignment: selectedItem == index
                                        ? Alignment(-1.8, 0)
                                        : Alignment(-0.3, 0)),
                                onTap: () {
                                  selectItem(index);
                                },
                                leading: selectedItem == index
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              Divider(
                                indent: 20,
                                endIndent: 20,
                                color: Colors.white,
                              )
                            ]);
                          }))
                ]))));
  }
}

class PresetWindowModulation extends StatelessWidget {
  const PresetWindowModulation(
      {Key? key,
      required this.selectModulation,
      required this.selectedModulation})
      : super(key: key);

  final Function selectModulation;
  final int selectedModulation;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30, bottom: 30),
        color: Colors.white60,
        child: SafeArea(
            child: Container(
                constraints: BoxConstraints(maxWidth: 350),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(7, 117, 229, 1.0),
                          Color.fromRGBO(12, 232, 92, 1.0),
                        ]),
                    border: Border.all(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          iconSize: 35,
                          onPressed: () {
                            selectModulation(-1);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ))),
                  Expanded(
                      child: ListView.builder(
                          itemCount: modulations.keys.toList().length,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              ListTile(
                                title: Align(
                                    child: Text(
                                      modulations.keys.toList()[index],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 23.0),
                                    ),
                                    alignment: selectedModulation == index
                                        ? Alignment(-1.8, 0)
                                        : Alignment(-0.3, 0)),
                                onTap: () {
                                  selectModulation(index);
                                },
                                leading: selectedModulation == index
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              Divider(
                                indent: 20,
                                endIndent: 20,
                                color: Colors.white,
                              )
                            ]);
                          }))
                ]))));
  }
}

class PresetWindowAudio extends StatelessWidget {
  const PresetWindowAudio(
      {Key? key, required this.selectAudio, required this.selectedAudio})
      : super(key: key);

  final Function selectAudio;
  final int selectedAudio;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 30, bottom: 30),
        color: Colors.white60,
        child: SafeArea(
            child: Container(
                constraints: BoxConstraints(maxWidth: 350),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(7, 117, 229, 1.0),
                          Color.fromRGBO(12, 232, 92, 1.0),
                        ]),
                    border: Border.all(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          iconSize: 35,
                          onPressed: () {
                            selectAudio(-1);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ))),
                  Expanded(
                      child: ListView.builder(
                          itemCount: audios.keys.toList().length,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              ListTile(
                                title: Align(
                                    child: Text(
                                      audios.keys.toList()[index],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 23.0),
                                    ),
                                    alignment: selectedAudio == index
                                        ? Alignment(-1.8, 0)
                                        : Alignment(-0.3, 0)),
                                onTap: () {
                                  selectAudio(index);
                                },
                                leading: selectedAudio == index
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              Divider(
                                indent: 20,
                                endIndent: 20,
                                color: Colors.white,
                              )
                            ]);
                          }))
                ]))));
  }
}
