<<<<<<< HEAD
// ignore_for_file: import_of_legacy_library_into_null_safe

=======
>>>>>>> 03fc1192a2861b356c3712d4116fefeeb52b3c37
import 'dart:async';
import 'dart:math';
import 'dart:developer';

// https://docs.flutter.dev/development/accessibility-and-localization/internationalization
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

import 'screens/mainscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      debugShowCheckedModeBanner:
          false, //Чтобы не было бейджика debug при разработке
      /* Вручную прописанную локализацию заменяют 2 строчки ниже
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English, no country code
          Locale('ru', ''), // Russian, no country code
        ]
        */
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
