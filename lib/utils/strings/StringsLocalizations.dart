import 'package:flutter/material.dart';


class StringsLocalizations {

  static StringsLocalizations of(BuildContext context) {
    return Localizations.of<StringsLocalizations>(context, StringsLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Hello World',
    },
    'ru': {
      'title': 'привет',
      'settings': 'Настройки',
      'Sign_out?': 'Выйти из аккаунта?',
      'Yes': 'Да',
      'No': 'Нет',
      'GO_OUT':'ВЫЙТИ'
    },
  };

  static String getString(BuildContext context, String string) {
    return _localizedValues[Localizations.localeOf(context).languageCode][string];
  }
}
