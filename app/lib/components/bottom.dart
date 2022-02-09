// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html

// icons HERE:
// https://api.flutter.dev/flutter/material/Icons-class.html
// https://mui.com/components/material-icons/
// https://icons8.com/icons/set/mantra

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
  if (globals.pages.length>=2)
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      if (globals.pages["home"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppLocalizations.of(context)!.home,
          backgroundColor: Colors.purple,
        ),
      if (globals.pages["programs"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_play),
          label: AppLocalizations.of(context)!.programs,
          backgroundColor: Colors.purple,
        ),
      if (globals.pages["mantras"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.self_improvement),
          label: AppLocalizations.of(context)!.mantras,
          backgroundColor: Colors.purple,
        ),
      if (globals.pages["af"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.volume_up),
          label: AppLocalizations.of(context)!.af,
          backgroundColor: Colors.purple,
        ),
      if (globals.pages["rf"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_input_antenna),
          label: AppLocalizations.of(context)!.rf,
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
      if (globals.pages["d3d"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.threed_rotation),
          label: AppLocalizations.of(context)!.d3d,
          backgroundColor: Colors.purple,
        ),
      if (globals.pages["imask"] != null)
        BottomNavigationBarItem(
          icon: Icon(Icons.masks),
          label: AppLocalizations.of(context)!.imask,
          backgroundColor: Colors.purple,
        ),
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

  return SizedBox.shrink();
}
