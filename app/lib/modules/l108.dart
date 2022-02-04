// Модуль язкового перевода

// https://localazy.com/docs/cli/flutter-format

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'l108/ru.dart';
const l108_lang={"ru":l108_ru};
const tr=l108_ru;

String l108t(text) {
  //var tr = AppLocalizations.of(context)!.transtlations;
  //var tr = AppLocalizations.of(context)!.transtlations;
  //print (Localizations.localeOf(context).toString());
  return tr[text]??"";
}

String l108o(text) {
  //var tr = AppLocalizations.of(context)!.transtlations;
  //var tr = AppLocalizations.of(context)!.transtlations;
  return tr[text]??text;
}
