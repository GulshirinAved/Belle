import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generate/app_localizations.dart';
import 'tk_localization/tk_cupertino_localization.dart';
import 'tk_localization/tk_material_localization.dart';

class L10n {
  static const List<LocalizationsDelegate> appDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    TkMaterialLocalization.delegate,
    TkCupertinoLocalization.delegate,
    // SfGlobalLocalizations.delegate,
  ];

  // Supported locales list
  static const List<Locale> supportedLocales = <Locale>[
    Locale('tk'),
    Locale('ru'),
    Locale('en'),
  ];

  static const Map<String, String> supportedLocaleNames = {
    'tk': 'Türkmen',
    'en': 'English',
    'ru': 'Русский',
  };
}
