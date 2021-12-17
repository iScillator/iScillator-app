import 'package:flutter/material.dart';

import '/elements/selectbutton.dart';

import '/globals.dart' as globals;

List<Widget> ifSelect(BuildContext context, item) {
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
        buttonName: (globals.selected[item] != -1
                ? globals.select[item].keys.toList()[globals.selected[item]]
                : "-") ??
            "-" /*items*/,
        //tapMethod: globals.showWindow,
      ),
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
    //...ifSelect(context, "program"),
  ]);
}

Widget pageTargets(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "target"),
    ...ifSelect(context, "enviroment"),
  ]);
}

Widget pageModulations(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "multi"),
    ...ifSelect(context, "modulation"),
  ]);
}

Widget pageDevices(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifSelect(context, "oscillator"),
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
    ...ifSelect(context, "angle"),
  ]);
}
