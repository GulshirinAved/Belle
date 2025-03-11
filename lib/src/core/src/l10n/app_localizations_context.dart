import 'package:flutter/widgets.dart';

import 'generate/app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
