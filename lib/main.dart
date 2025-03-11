import 'package:belle/src/core/core.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'firebase_options.dart';
import 'src/app.dart';
import 'src/features/language/controller/language_controller.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/Onest/OFL.txt');
    yield LicenseEntryWithLineBreaks(['Onest Font (Google Fonts)'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await KeyValueStorageBase.init();
  AppInjections.registerBasicInjections();
  AppInjections.registerAppInjections();

  final langController = GetIt.instance<LanguageController>();

  langController.fetchLocale();
  Intl.defaultLocale = langController.localeCode;
  GetIt.instance<ThemeController>().fetchTheme();
  GetIt.instance<ThemeController>().listenToSystemThemeChanges();

  runApp(const BelleApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}
