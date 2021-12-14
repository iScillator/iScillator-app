import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/globals.dart' as globals;

Widget frequencySection(BuildContext context) {
  return Stack(
    alignment: Alignment.center,
    clipBehavior: Clip.none,
    children: [
      Text('${globals.frequency.toInt()} Hz',
          style: TextStyle(color: Colors.white70, fontSize: 60.0)),
      Positioned(
        child: Text(AppLocalizations.of(context)!.frequency, // 'Frequency',
            style: TextStyle(color: Colors.white70, fontSize: 20.0)),
        top: 65.0,
      )
    ],
  );
}
