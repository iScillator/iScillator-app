import 'package:flutter/material.dart';

import '/elements/selectbutton.dart';

import '/globals.dart' as globals;

List<Widget> ifSelect(BuildContext context, page, item, item0) {
/*
  print(item);
  print(items);
  print(globals.selected);
  print(globals.selected[item]);
  print(globals.select[items].keys.toList());
*/
  return [
    //Text(item),
    //if (globals.select[item] != null)
    if (globals.config["pages"][page].contains(item))
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
    if (globals.config["pages"][page].contains(item))
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
    ...ifSelect(context, "programs","folder","all"),
    ...ifSelect(context, "programs","category","all"),
    ...ifSelect(context, "programs","program","not selected"),
  ]);
}

Widget pageTargets(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "targets", "target","not selected"),
    ...ifSelect(context, "targets", "enviroment","not selected"),
  ]);
}

Widget pageModulations(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "modulations", "multi","not selected"),
    ...ifSelect(context, "modulations", "modulation","not selected"),
    ...ifSelect(context, "modulations", "waveform","not selected"),
  ]);
}

Widget pageDevices(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "devices","oscillator","not selected"),
    ...ifSelect(context, "devices","emmiter","not selected"),
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
    ...ifSelect(context,"settings", "audio","not selected"),
    ...ifSelect(context,"settings", "angle","not selected"),
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
