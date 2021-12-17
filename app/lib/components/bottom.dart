// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html

// https://api.flutter.dev/flutter/material/Icons-class.html

//https://api.flutter.dev/flutter/cupertino/CupertinoTabBar-class.html

// TODO: https://stackoverflow.com/questions/61269906/flutter-bottom-navigation-bar-with-pageview

import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/globals.dart' as globals;

void _onItemTapped(int index) {
  globals.setState(() {
    globals.selectedPage = index;

    //TODO:ADD ALL PAGES FALSE in loop
    globals.isWindowShown["target"] = false;
    globals.isWindowShown["angle"] = false;

    print(globals.isWindowShown);
  });
  globals.pageController.jumpToPage(index);
}

// TODO: Add IfItem

Widget myBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
/*
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home", //AppLocalizations.of(context)!.home
        backgroundColor: Colors.purple,
      ),*/
      if (globals.pages["programs"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_play),
          label: AppLocalizations.of(context)!.programs,
          backgroundColor: Colors.purple,
        ),
      if (globals.pages["targets"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.grain),
          label: AppLocalizations.of(context)!.targets,
          backgroundColor: Colors.purple,
        ),
      if (globals.pages["modulations"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.graphic_eq),
          label: AppLocalizations.of(context)!.modulation,
          backgroundColor: Colors.purple,
        ),
      if (globals.pages["devices"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_input_component_outlined),
          label: AppLocalizations.of(context)!.devices,
          backgroundColor: Colors.purple,
        ),

/*
      BottomNavigationBarItem(
        icon: Icon(Icons.threed_rotation),
        label: "3D", //AppLocalizations.of(context)!.d3d,
        backgroundColor: Colors.purple,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.masks),
        label: "iMask", //AppLocalizations.of(context)!.imask,
        backgroundColor: Colors.purple,
      ),

      BottomNavigationBarItem(
        icon: "ॐ",
        label: "Mantras", //AppLocalizations.of(context)!.imask,
        backgroundColor: Colors.purple,
      ),


      */
      if (globals.pages["settings"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: AppLocalizations.of(context)!.settings,
          backgroundColor: Colors.purple,
        ),
    ],
    currentIndex: globals.selectedPage,
    selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped,
  );
}
