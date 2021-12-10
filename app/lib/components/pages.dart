import 'package:flutter/material.dart';

import '/elements/presetwindow.dart';
import '/elements/selectpresetbutton.dart';

import '/globals.dart' as globals;

List<Widget> ifMenu(BuildContext context, item, items) {
  return [
    //Text(item),
    if (globals.menu[items] != null) Text(item)
    /*SelectPresetButton(
        item: item,
        items: items,
        presetName: items.keys.toList()[globals.selected[item]],
        tapMethod: globals.showPresetWindow,
      )*/
    ,
    if (globals.menu[items] != null)
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
    ...ifMenu(context, "folders", "folders"),
    ...ifMenu(context, "programs", "programs"),
  ]);
}

Widget pageTargets(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifMenu(context, "target", "targets"),
    ...ifMenu(context, "enviroment", "enviroments"),
  ]);
}

Widget pageModulations(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifMenu(context, "multis", "multis"),
    ...ifMenu(context, "modulation", "modulations"),
  ]);
}

Widget pageDevices(BuildContext context) {
  return Column(children: [
    Divider(
      indent: 60,
      endIndent: 60,
      color: Colors.white,
    ),
    ...ifMenu(context, "audioDevice", "audioDevices"),
    ...ifMenu(context, "angle", "angles"),
  ]);
}
