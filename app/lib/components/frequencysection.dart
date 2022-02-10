import 'package:flutter/material.dart';

import '/globals.dart' as globals;

String Double2Str(double i) {
  if (i.toInt() == i.toDouble()) return i.toInt().toString();
  return i.toDouble().toString();
}

Widget frequencySection(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    clipBehavior: Clip.none,
    children: [
      Text('${(globals.frequency == 0) ? globals.AppLocalizations.of(context)!.noFrequency : Double2Str(globals.frequency) + " Hz"}',
          style: TextStyle(color: Colors.white60, fontSize: 60.0)),
      Positioned(
        child: Text(globals.AppLocalizations.of(context)!.frequency, // 'Frequency',
            style: TextStyle(color: Colors.white54, fontSize: 20.0)),
        top: 65.0,
      )
    ],
  );
}
