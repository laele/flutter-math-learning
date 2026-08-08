import 'package:flutter/cupertino.dart';
import 'package:flutter_math_app/core/l10n/app_supported_locales.dart';

class LocaleResolver {
  static String resolveDeviceLanguage() {
    final deviceCode = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    return AppSupportedLocales.codes.keys.contains(deviceCode) ? deviceCode : AppSupportedLocales.fallbackCode;
  }
}
