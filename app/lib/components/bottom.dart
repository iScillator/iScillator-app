// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html

// https://api.flutter.dev/flutter/material/Icons-class.html

//https://api.flutter.dev/flutter/cupertino/CupertinoTabBar-class.html

// TODO: https://stackoverflow.com/questions/61269906/flutter-bottom-navigation-bar-with-pageview
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

int _selectedPage = 0;
var ss; //setState

void _onItemTapped(int index) {
  //setState(() {
  ss(() {
    _selectedPage = index;
  });
}

BottomNavigationBar myBottomNavigationBar(context, ss1) {
  ss = ss1;
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home", //AppLocalizations.of(context)!.home,
        backgroundColor: Colors.purple,
      ),
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
        icon: Icon(Icons.settings),
        label: "Settings", //AppLocalizations.of(context)!.settings,
        backgroundColor: Colors.purple,
      ),
    ],
    currentIndex: _selectedPage,
    selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped,
  );
}
