// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html

// icons HERE:
// https://api.flutter.dev/flutter/material/Icons-class.html
// https://mui.com/components/material-icons/
// https://icons8.com/icons/set/mantra

//https://api.flutter.dev/flutter/cupertino/CupertinoTabBar-class.html

// TODO: https://stackoverflow.com/questions/61269906/flutter-bottom-navigation-bar-with-pageview

import 'package:flutter/material.dart';

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
  if (globals.pages.length >= 2)
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        if (globals.pages["home"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: globals.AppLocalizationsOC!.home,
            backgroundColor: Colors.purple,
          ),
        if (globals.pages["programs"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            label: globals.AppLocalizationsOC!.programs,
            backgroundColor: Colors.purple,
          ),
        if (globals.pages["mantras"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement),
            label: globals.AppLocalizationsOC!.mantras,
            backgroundColor: Colors.purple,
          ),
        if (globals.pages["af"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.volume_up),
            label: globals.AppLocalizationsOC!.af,
            backgroundColor: Colors.purple,
          ),
        if (globals.pages["rf"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_input_antenna),
            label: globals.AppLocalizationsOC!.rf,
            backgroundColor: Colors.purple,
          ),
        if (globals.pages["targets"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.grain),
            label: globals.AppLocalizationsOC!.targets,
            backgroundColor: Colors.purple,
          ),
        if (globals.pages["modulations"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            label: globals.AppLocalizationsOC!.modulation,
            backgroundColor: Colors.purple,
          ),
        if (globals.pages["devices"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_input_component_outlined),
            label: globals.AppLocalizationsOC!.devices,
            backgroundColor: Colors.purple,
          ),
        if (globals.pages["d3d"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.threed_rotation),
            label: globals.AppLocalizationsOC!.d3d,
            backgroundColor: Colors.purple,
          ),
        if (globals.pages["imask"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.masks),
            label: globals.AppLocalizationsOC!.imask,
            backgroundColor: Colors.purple,
          ),
        if (globals.pages["settings"] != null)
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: globals.AppLocalizationsOC!.settings,
            backgroundColor: Colors.purple,
          ),
      ],
      currentIndex: globals.selectedPage,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );

  return SizedBox.shrink();
}
