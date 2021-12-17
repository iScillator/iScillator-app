import 'package:flutter/material.dart';
import 'package:sound_generator/sound_generator.dart';

import '/globals.dart' as globals;

import '/elements/selectwindow.dart';

import '/components/pages.dart';
import '/components/frequencysection.dart';
import '/components/playbutton.dart';

List ifWindow(BuildContext context, item) {
  //print(ifWindow);
  //print(globals.isWindowShown[item]);
  return [
    if (globals.isWindowShown[item] == true)
      SelectWindow(
        item: item,
        //items: items,
        //selectItem: _select,
        //selectedItem: _selected,
      )
  ];
}

Widget mainBody(BuildContext context) {
  globals.pageController = PageController(initialPage: 0);
  return SafeArea(
    child: Stack(
      children: [
        Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
              child: frequencySection(context)),
          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
              child: PlayButton(onPlayingChange: globals.play)),
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
                  if (globals.pages["programs"] != null) pagePrograms(context),
                  if (globals.pages["targets"] != null) pageTargets(context),
                  if (globals.pages["modulations"] != null)
                    pageModulations(context),
                  if (globals.pages["devices"] != null) pageDevices(context),
                  if (globals.pages["settings"] != null) pageSettings(context),
                ]),
          )
        ]),
        ...ifWindow(context, "program"),
        ...ifWindow(context, "oscillator"),
        ...ifWindow(context, "angle"),
        ...ifWindow(context, "enviroment"),
        ...ifWindow(context, "modulation"),
        ...ifWindow(context, "multi"),
        ...ifWindow(context, "targets"),
      ],
    ),
  );
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

*/
