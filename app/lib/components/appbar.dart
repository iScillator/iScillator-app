//https://www.kindacode.com/article/flutter-add-a-search-field-to-the-app-bar/
// https://api.flutter.dev/flutter/cupertino/CupertinoSearchTextField-class.html

import 'package:flutter/material.dart';

import '/globals.dart' as globals;
import '/config/version.dart';

Widget mainTitle() {
  return Row(children: [
    Text(globals.config["title"]),
    Expanded(
        child: Column(children: [
      if (globals.config["visible"]["description"])
        Container(
            alignment: Alignment.centerRight,
            child: Text(globals.config["description"], textAlign: TextAlign.end, style: TextStyle(color: Colors.white70, fontSize: 10.0))),
      if (globals.config["visible"]["build"])
        Container(
            alignment: Alignment.centerRight,
            child: Text(buildName + "+" + buildNumber.toString(),
                textAlign: TextAlign.end, style: TextStyle(color: Colors.white60, fontSize: 10.0))),
    ]))
  ]);
}

AppBar mainAppBar(context) {
  return AppBar(
    title: Column(children: [
      //if (globals.isSearchShown != true)
      mainTitle(),
      //if (globals.isSearchShown == true) SearchText(context)
    ]),
  );
}
