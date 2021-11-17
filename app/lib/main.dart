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
  bool _isPresetWindowShown = false;
  int _selectedSound = 0;
  double _frequency = 0;

  final sounds=['Muladhara', 'Svadhisthana', 'Manipura','Anahata','Vishudha','Adjna','Sahasrara'];



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
      if (userSettings?.waveType == 4) _waveType = waveTypes.MULTI;
      if (userSettings?.waveType == 5) _waveType = waveTypes.MULTI;

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
              SelectPresetButton(
                presetName: sounds[_selectedSound],
                tapMethod: _showPresetWindow,
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
            if (_isPresetWindowShown)
              PresetWindow(
                selectSound: _selectSound,
                selectedSound: _selectedSound,
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
        if (_selectedSound == 0) {
          _presetFrequency = 285;
          SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
        }
        if (_selectedSound == 1) {
          _presetFrequency = 396;
          SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
        }
        if (_selectedSound == 2) {
          _presetFrequency = 417;
          SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
        }
        if (_selectedSound == 3) {
          _presetFrequency = 528;
          SoundGenerator.setWaveType(waveTypes.MULTI);
        }
        if (_selectedSound == 4) {
          _presetFrequency = 639;
          SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
        }
        if (_selectedSound == 5) {
          _presetFrequency = 741;
          SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
        }
        if (_selectedSound == 6) {
          _presetFrequency = 852;
          SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
        }
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

  void _showPresetWindow() {
    setState(() {
      _isPresetWindowShown = true;
    });
  }

  void _selectSound(int sound) {
    setState(() {
      if (sound == -1) {
        _isPresetWindowShown = false;
      } else {
        _selectedSound = sound;
        _isPresetWindowShown = false;
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
      {Key? key, required this.selectSound, required this.selectedSound})
      : super(key: key);

  final Function selectSound;
  final int selectedSound;

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
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            iconSize: 35,
                            onPressed: () {
                              selectSound(-1);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ))),
                    Expanded(
                        child: ListView(
                      children: <Widget>[
                        Divider(
                          indent: 20,
                          endIndent: 20,
                          color: Colors.white,
                        ),

                        //final sounds=['Muladhara', 'Svadhisthana', 'Manipura','Anahata','Vishudha','Adjna','Sahasrara'];

                    ListTile(
                          title: Align(
                              child: Text(
                                'Muladhara',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23.0),
                              ),
                              alignment: selectedSound == 0
                                  ? Alignment(-1.8, 0)
                                  : Alignment(-0.3, 0)),
                          onTap: () {
                            selectSound(0);
                          },
                          leading: selectedSound == 0
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
                        ),
                        ListTile(
                          title: Align(
                              child: Text('Svadhisthana',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23.0)),
                              alignment: selectedSound == 1
                                  ? Alignment(-2.1, 0)
                                  : Alignment(-0.2, 0)),
                          onTap: () {
                            selectSound(1);
                          },
                          leading: selectedSound == 1
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
                        ),
                        ListTile(
                          title: Align(
                              child: Text('Manipura',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23.0)),
                              alignment: selectedSound == 2
                                  ? Alignment(-2.4, 0)
                                  : Alignment(-0.1, 0)),
                          onTap: () {
                            selectSound(2);
                          },
                          leading: selectedSound == 2
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
                        ),
                        ListTile(
                          title: Align(
                              child: Text('Anahata',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23.0)),
                              alignment: selectedSound == 3
                                  ? Alignment(-2.4, 0)
                                  : Alignment(-0.1, 0)),
                          onTap: () {
                            selectSound(3);
                          },
                          leading: selectedSound == 3
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
                        ),
                        ListTile(
                          title: Align(
                              child: Text('Vishudha',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23.0)),
                              alignment: selectedSound == 4
                                  ? Alignment(-2.4, 0)
                                  : Alignment(-0.1, 0)),
                          onTap: () {
                            selectSound(4);
                          },
                          leading: selectedSound == 4
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
                        ),
                        ListTile(
                          title: Align(
                              child: Text('Adjna',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23.0)),
                              alignment: selectedSound == 5
                                  ? Alignment(-2.4, 0)
                                  : Alignment(-0.1, 0)),
                          onTap: () {
                            selectSound(5);
                          },
                          leading: selectedSound == 5
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
                        ),
                        ListTile(
                          title: Align(
                              child: Text('Sahasrara',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23.0)),
                              alignment: selectedSound == 6
                                  ? Alignment(-2.4, 0)
                                  : Alignment(-0.1, 0)),
                          onTap: () {
                            selectSound(6);
                          },
                          leading: selectedSound == 6
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
                      ],
                    ))
                  ],
                ))));
  }
}
