import 'package:flutter/material.dart';
import 'package:soundhealer/models/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen(
      {Key? key, required this.userSettings, required this.prefs})
      : super(key: key);

  final SharedPreferences? prefs;
  final UserSettings? userSettings;

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
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
            child: SafeArea(
                child: Column(
              children: [
                Align(
                  child: IconButton(
                      iconSize: 35,
                      onPressed: () {
                        _saveSettings();

                        waveTypes? _waveType;
                        _waveType=waveTypes.SINUSOIDAL;
                        if (widget.userSettings?.waveType == 0)
                          _waveType = waveTypes.SINUSOIDAL;
                        if (widget.userSettings?.waveType == 1)
                          _waveType = waveTypes.SQUAREWAVE;
                        if (widget.userSettings?.waveType == 2)
                          _waveType = waveTypes.TRIANGLE;
                        if (widget.userSettings?.waveType == 3)
                          _waveType = waveTypes.SAWTOOTH;

                        SoundGenerator.setWaveType(_waveType);
                        //SoundGenerator.setBalance(widget.userSettings?.balance);

                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                  alignment: Alignment.centerRight,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Text('Balance',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ))),
                        Row(
                          children: [
                            Text('L',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            Expanded(
                                child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                        trackShape:
                                            RectangularSliderTrackShape()),
                                    child: Slider(
                                        value:
                                            widget.userSettings?.balance ?? 0.0,
                                        onChanged: (_value) {
                                          setState(() {
                                            widget.userSettings?.balance =
                                                _value;
                                          });
                                        },
                                        min: -1.0,
                                        max: 1.0,
                                        divisions: 20,
                                        activeColor: Colors.white,
                                        inactiveColor: Colors.white))),
                            Text('R',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Text(_getFormattedSliderValue(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                        Padding(
                            padding: EdgeInsets.only(top: 50.0, bottom: 25.0),
                            child: Text('Wave Form',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                ))),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<int?>(
                              value: widget.userSettings?.waveType ?? 0,
                              onChanged: (waveType) {
                                setState(() {
                                  widget.userSettings?.waveType = waveType;
                                });
                              },
                              items: <int>[0, 1, 2, 3].map((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child:
                                      Text(_getFormattedDropdownValue(value)),
                                );
                              }).toList(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                              iconEnabledColor: Colors.white,
                              dropdownColor: Color.fromRGBO(10, 183, 151, 1.0),
                            ))),
                      ],
                    ))
              ],
            ))));
  }

  String _getFormattedSliderValue() {
    double sliderValue = widget.userSettings?.balance ?? 0.0;
    return sliderValue.toStringAsFixed(1);
  }

  String _getFormattedDropdownValue(value) {
    if (value == 0) return 'SINUSOIDAL';
    if (value == 1) return 'SQUAREWAVE';
    if (value == 2) return 'TRIANGLE';
    if (value == 3) return 'SAWTOOTH';
    return '';
  }

  void _saveSettings() async {
    SharedPreferences? prefs = widget.prefs;
    if (prefs != null) {
      await prefs.setDouble('balance', widget.userSettings?.balance ?? 0.0);
      await prefs.setInt('waveType', widget.userSettings?.waveType ?? 0);
    } else {
      prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('balance', widget.userSettings?.balance ?? 0.0);
      await prefs.setInt('waveType', widget.userSettings?.waveType ?? 0);
    }
  }
}
