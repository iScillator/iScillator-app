import 'package:flutter/material.dart';
import 'package:sound_generator/sound_generator.dart';

import '/globals.dart' as globals;

import '/components/pages.dart';
import '/components/frequencysection.dart';
import '/components/playbutton.dart';

/*
Widget ifPresetWindow(item,items)
{
          return Container(child: if (_isPresetWindowShown[item])
          PresetWindow(
            item: item,
            items: items,
            selectItem: _select,
            selectedItem: _selected,
          ));
}
*/

Widget mainBody(BuildContext context) {
  globals.pageController = PageController(initialPage: 0);
  return SafeArea(
    child: Stack(
      children: [
        Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
              child: frequencySection(context)),
          PlayButton(onPlayingChange: _play),
          Expanded(
            child: PageView(
                scrollDirection: Axis.horizontal,
                controller: globals.pageController,
                onPageChanged: (int page) {
                  globals.setState(() {
                    globals.selectedPage = page;
                  });
                },
                children: [
                  pagePrograms(context),
                  pageTargets(context),
                  pageModulations(context),
                  pageDevices(context),
                  Text("settings")
                ]),
          )
        ]), /*ifPresetWindow("audioDevice",menu["audioDevices"]),
        ifPresetWindow("angle",menu["angles"]),
        //channels depreciated
        ifPresetWindow("enviroment",menu["enviroments"]),
        ifPresetWindow("modulation",menu["modulations"]),
        ifPresetWindow("multi",menu["multis"]),
        ifPresetWindow("targets",menu["targets"]),*/
      ],
    ),
  );
}

void _play() {
  globals.setState(() {
    globals.isPlaying = !globals.isPlaying;

    if (globals.isPlaying) {
      globals.setParams();
      globals.SoundGenerator.play();

      /*
        _timer = Timer.periodic(Duration(seconds: 2), (timer) {
          setState(() {
            _frequency = _presetFrequency + Random().nextInt(1000);
            SoundGenerator.setFrequency(_frequency);
          });
        });
        */
    } else {
      globals.setState(() {
        //_timer?.cancel();
        //_timer = null;
        globals.SoundGenerator.stop();
        globals.frequency = 0;
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

/*

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

void _selectItem(int num, item) {
  setState(() {
    if (num == -1) {
      _isPresetWindowShown[item] = false;
    } else {
      _selected[item] = num;
      UserSettings[item] = menu[item].values.toList()[num]; //was audio=
      _isPresetWindowShown[item] = false;
      setParams();
    }
  });
}
*/
