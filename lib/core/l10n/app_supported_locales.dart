import 'package:flutter/widgets.dart';

class AppSupportedLocales {
  static const List<Locale> locales = [
    Locale('es'),
    Locale('en'),
    Locale('pt'),
    Locale('zh'),
    Locale('fr'),
    Locale('hi'),
    Locale('ko'),
    Locale('ja'),
    Locale('tl'),
  ];
  static const Map<String, String> codes = {
    'es': 'Español',
    'en': 'English',
    'pt': 'Português',
    'zh': '简体中文',
    'fr': 'Français',
    'hi': 'हिन्दी',
    'ko': '한국어',
    'ja': '日本語',
    'tl': 'Tagalog',
  };
  static const String fallbackCode = 'en';
}
