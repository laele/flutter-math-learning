import 'package:flutter/widgets.dart';

class AppSupportedLocales {
  static const List<Locale> locales = [
    Locale('es'),
    Locale('en'),
    Locale('pt'),
  ];
  static const Map<String, String> codes = {
    'es': 'Español',
    'en': 'English',
    'pt': 'Português',
  };
  static const String fallbackCode = 'en';
}
