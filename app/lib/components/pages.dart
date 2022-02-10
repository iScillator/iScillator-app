import 'package:flutter/material.dart';

import '/elements/selectbutton.dart';

import '/globals.dart' as globals;

List<Widget> ifSelect(BuildContext context, item, item0) {
/*
  print(item);
  print(items);
  print(globals.selected);
  print(globals.selected[item]);
  print(globals.select[items].keys.toList());
*/
  return [
    //Text(item),
    if (globals.select[item] != null)
      SelectButton(
        item: item,
        buttonName: globals.selected[item]??item0
        /*
        (globals.selected[item] != ""
                ? globals.selected[item]
                : "-") */
             /*items*/,
        //tapMethod: globals.showWindow,
      ),
      //globals.userSettings
      //globals.select_rev["program"]
    if (globals.select[item] != null)
      Divider(
        indent: 60,
        endIndent: 60,
        color: Colors.white,
      ),
  ];
}

// pagePrograms
Widget pagePrograms(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "folder","all"),
    ...ifSelect(context, "category","all"),
    ...ifSelect(context, "program","not selected"),
  ]);
}

Widget pageTargets(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "target","not selected"),
    ...ifSelect(context, "enviroment","not selected"),
  ]);
}

Widget pageModulations(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "multi","not selected"),
    ...ifSelect(context, "modulation","not selected"),
  ]);
}

Widget pageDevices(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "oscillator","not selected"),
  ]);
}

Widget pageSettings(BuildContext context) {
  return /*SingleChildScrollView(
      child:*/
      Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "angle","not selected"),
  ]);
}

Widget pageText(BuildContext context, text) {
  return /*SingleChildScrollView(
      child:*/
      Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    Text(text),
  ]);
}
