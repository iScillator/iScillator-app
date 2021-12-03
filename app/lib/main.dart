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
import 'dart:developer';
//import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/settings.dart';
import 'models/user_settings.dart';

import 'dart:io' show Platform;

//import 'package:flutter/foundation.dart';

import 'config/configs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainScreen(),debugShowCheckedModeBanner: false);
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

  static int audio = defaults["audio"];
  static int channel = defaults["channel"];
  static int enviroment = defaults["enviroment"];
  static int modulation = defaults["modulation"];
  static int multi = defaults["multi"];
  static int target = defaults["target"];

  int _selectedAudio = menu_rev["audios"].keys.toList().indexOf(audio);
  int _selectedChannel = menu_rev["channels"].keys.toList().indexOf(channel);
  int _selectedEnviroment =
      menu_rev["enviroments"].keys.toList().indexOf(enviroment);
  int _selectedModulation =
      menu_rev["modulations"].keys.toList().indexOf(modulation);
  int _selectedMulti = menu_rev["multis"].keys.toList().indexOf(multi);
  int _selectedTarget = menu_rev["targets"].keys.toList().indexOf(target);

  double _frequency = 0;

  //Timer? _timer;

  SharedPreferences? prefs;
  UserSettings? userSettings;

  @override
  void initState() {
    super.initState();

    //log(audio);
    //print(menu.targets);
    print(menu);
    print(menu_rev);
    print(audio);
    print(_selectedAudio);
    //print(audios_rev);

    //test = 12345;
    //print(test);

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
              */
              Divider(
                indent: 60,
                endIndent: 60,
                color: Colors.white,
              ),
              if (menu["targets"] != null)
                SelectPresetButton(
                  presetName: menu["targets"].keys.toList()[_selectedTarget],
                  tapMethod: _showPresetWindowTargets,
                ),
              if (menu["targets"] != null)
                Divider(
                  indent: 60,
                  endIndent: 60,
                  color: Colors.white,
                ),
              if (menu["enviroments"] != null)
                SelectPresetButton(
                  presetName:
                      menu["enviroments"].keys.toList()[_selectedEnviroment],
                  tapMethod: _showPresetWindowEnviroments,
                ),
              if (menu["enviroments"] != null)
                Divider(
                  indent: 60,
                  endIndent: 60,
                  color: Colors.white,
                ),
              if (menu["modulations"] != null)
                SelectPresetButton(
                  presetName:
                      menu["modulations"].keys.toList()[_selectedModulation],
                  tapMethod: _showPresetWindowModulations,
                ),
              if (menu["modulations"] != null)
                Divider(
                  indent: 60,
                  endIndent: 60,
                  color: Colors.white,
                ),
              if (menu["multis"] != null)
                SelectPresetButton(
                  presetName: menu["multis"].keys.toList()[_selectedMulti],
                  tapMethod: _showPresetWindowMultis,
                ),
              if (menu["multis"] != null)
                Divider(
                  indent: 60,
                  endIndent: 60,
                  color: Colors.white,
                ),
              if (menu["channels"] != null)
                SelectPresetButton(
                  presetName: menu["channels"].keys.toList()[_selectedChannel],
                  tapMethod: _showPresetWindowChannels,
                ),
              if (menu["channels"] != null)
                Divider(
                  indent: 60,
                  endIndent: 60,
                  color: Colors.white,
                ),
              if (menu["audios"] != null)
                SelectPresetButton(
                  presetName: menu["audios"].keys.toList()[_selectedAudio],
                  tapMethod: _showPresetWindowAudios,
                ),
              if (menu["audios"] != null)
                Divider(
                  indent: 60,
                  endIndent: 60,
                  color: Colors.white,
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
                items: menu["audios"],
                selectItem: _selectAudio,
                selectedItem: _selectedAudio,
              ),
            if (_isPresetWindowChannelsShown)
              PresetWindow(
                items: menu["channels"],
                selectItem: _selectChannel,
                selectedItem: _selectedChannel,
              ),
            if (_isPresetWindowEnviromentsShown)
              PresetWindow(
                items: menu["enviroments"],
                selectItem: _selectEnviroment,
                selectedItem: _selectedEnviroment,
              ),
            if (_isPresetWindowModulationsShown)
              PresetWindow(
                items: menu["modulations"],
                selectItem: _selectModulation,
                selectedItem: _selectedModulation,
              ),
            if (_isPresetWindowMultisShown)
              PresetWindow(
                items: menu["multis"],
                selectItem: _selectMulti,
                selectedItem: _selectedMulti,
              ),
            if (_isPresetWindowTargetsShown)
              PresetWindow(
                items: menu["targets"],
                selectItem: _selectTarget,
                selectedItem: _selectedTarget,
              )
          ],
        ),
      ),
    );
  }

  void setParams() {
    double _presetFrequency = 0;

    _presetFrequency = target.toDouble();

    if (Platform.isIOS) {
      SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
    } else {
      SoundGenerator.setWaveType(waveTypes.MULTI);
      SoundGenerator.setParams(
          target.toDouble(),
          enviroment.toDouble(),
          modulation.toDouble(),
          multi.toDouble(),
          channel.toDouble(),
          audio.toDouble());
    }
    _frequency = _presetFrequency;
    SoundGenerator.setFrequency(_frequency);
  }

  void _play() {
    setState(() {
      _isPlaying = !_isPlaying;

      if (_isPlaying) {
        setParams();
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
          //_timer?.cancel();
          //_timer = null;
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
        audio = menu["audios"].values.toList()[num];
        _isPresetWindowAudiosShown = false;
        setParams();
      }
    });
  }

  void _selectChannel(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowChannelsShown = false;
      } else {
        _selectedChannel = num;
        channel = menu["channels"].values.toList()[num];
        _isPresetWindowChannelsShown = false;
        setParams();
      }
    });
  }

  void _selectEnviroment(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowEnviromentsShown = false;
      } else {
        _selectedEnviroment = num;
        enviroment = menu["enviroments"].values.toList()[num];
        _isPresetWindowEnviromentsShown = false;
        setParams();
      }
    });
  }

  void _selectModulation(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowModulationsShown = false;
      } else {
        _selectedModulation = num;
        modulation = menu["modulations"].values.toList()[num];
        _isPresetWindowModulationsShown = false;
        setParams();
      }
    });
  }

  void _selectMulti(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowMultisShown = false;
      } else {
        _selectedMulti = num;
        multi = menu["multis"].values.toList()[num];
        _isPresetWindowMultisShown = false;
        setParams();
      }
    });
  }

  void _selectTarget(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowTargetsShown = false;
      } else {
        _selectedTarget = num;
        target = menu["targets"].values.toList()[num];
        _isPresetWindowTargetsShown = false;
        setParams();
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
