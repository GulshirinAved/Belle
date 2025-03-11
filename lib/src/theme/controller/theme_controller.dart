// // ignore_for_file: library_private_types_in_public_api
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/core.dart';
import '../theme.dart';

part 'theme_controller.g.dart';

// class ThemeController = _ThemeControllerBase with _$ThemeController;
//
// abstract class _ThemeControllerBase with Store {
//   final _keyStorageService = KeyValueStorageService();
//
//   @observable
//   MainColorConfig mainColorConfig = MainColorConfig.standard();
//
//   @observable
//   ThemeStyleConfig _config = ThemeStyleConfig.auto;
//
//   @observable
//   ThemeMode _themeMode = ThemeMode.system;
//
//   @observable
//   ThemeData? _cachedThemeData;
//
//   @computed
//   ThemeMode get themeMode => _themeMode;
//
//   ThemeStyleConfig get config => _config;
//
//   ThemeData getCurrentThemeData() {
//     if (_cachedThemeData != null) {
//       return _cachedThemeData!;
//     }
//
//     switch (_config) {
//       case ThemeStyleConfig.light:
//         _cachedThemeData = ThemeData.light();
//         break;
//       case ThemeStyleConfig.dark:
//         _cachedThemeData = AppTheme.darkTheme();
//         break;
//       case ThemeStyleConfig.lightAccent:
//         _cachedThemeData = ThemeData.light();
//         break;
//       case ThemeStyleConfig.darkAccent:
//         _cachedThemeData = AppTheme.darkTheme(mainColorConfig);
//         break;
//       default:
//         _cachedThemeData = AppTheme.darkTheme();
//     }
//
//     return _cachedThemeData!;
//   }
//
//   @action
//   Future<void> fetchTheme() async {
//     try {
//       final savedTheme = _keyStorageService.getTheme();
//       final savedColorValue = _keyStorageService.getPrimaryColor();
//       final savedColor =
//           savedColorValue != null ? Color(savedColorValue) : null;
//
//       if (savedTheme != null) {
//         _config = ThemeStyleConfig.values.firstWhere(
//           (element) => element.toString() == savedTheme,
//           orElse: () => ThemeStyleConfig.dark,
//         );
//         if (savedColor != null) {
//           _generateNewColors(savedColor);
//         }
//         _updateThemeMode();
//       }
//     } catch (e) {
//       log('Ошибка загрузки темы: $e');
//     }
//   }
//
//   @action
//   Future<void> updateTheme(ThemeStyleConfig newConfig, [Color? color]) async {
//     try {
//       _config = newConfig;
//       await _keyStorageService.setTheme(newConfig.toString());
//
//       if (color != null) {
//         await _keyStorageService.setPrimaryColor(color.value);
//         _generateNewColors(color);
//       }
//
//       _updateThemeMode();
//       _cachedThemeData = null;
//     } catch (e) {
//       log('Ошибка обновления темы: $e');
//     }
//   }
//
//   void _updateThemeMode() {
//     switch (_config) {
//       case ThemeStyleConfig.light:
//         _themeMode = ThemeMode.light;
//         break;
//       case ThemeStyleConfig.dark:
//         _themeMode = ThemeMode.dark;
//         break;
//       case ThemeStyleConfig.lightAccent:
//         _themeMode = ThemeMode.light;
//         break;
//       case ThemeStyleConfig.darkAccent:
//         _themeMode = ThemeMode.dark;
//         break;
//       case ThemeStyleConfig.auto:
//         _themeMode = ThemeMode.system;
//         break;
//     }
//   }
//
//   @action
//   void _generateNewColors(Color color) {
//     mainColorConfig = ColorGenerator.generateColors(color);
//   }
//
//   @action
//   void listenToSystemThemeChanges() {
//     WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
//         () {
//       if (_config == ThemeStyleConfig.auto) {
//         _themeMode =
//             WidgetsBinding.instance.platformDispatcher.platformBrightness ==
//                     Brightness.dark
//                 ? ThemeMode.dark
//                 : ThemeMode.light;
//       }
//     };
//   }
// }

class ThemeController = _ThemeControllerBase with _$ThemeController;

abstract class _ThemeControllerBase with Store {
  final _keyStorageService = KeyValueStorageService();

  @observable
  MainColorConfig mainColorConfig = MainColorConfig.standard();

  @observable
  ThemeMode themeMode = ThemeMode.dark;

  @observable
  ThemeData? _cachedThemeData;

  // @action
  ThemeData getCurrentThemeData() {
    if (_cachedThemeData != null) return _cachedThemeData!;

    _cachedThemeData = themeMode == ThemeMode.light
        ? AppTheme.lightTheme(mainColorConfig)
        : AppTheme.darkTheme(mainColorConfig);

    return _cachedThemeData!;
  }

  @action
  Future<void> fetchTheme() async {
    try {
      final savedThemeMode = _keyStorageService.getTheme();
      final savedColorValue = _keyStorageService.getPrimaryColor();

      if (savedThemeMode != null) {
        themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == savedThemeMode,
          orElse: () => ThemeMode.system,
        );
      }

      if (savedColorValue != null) {
        final savedColor = Color(savedColorValue);
        mainColorConfig = ColorGenerator.generateColors(savedColor);
      }
    } catch (e) {
      log('Ошибка загрузки темы: $e');
    }
  }

  @action
  Future<void> updateThemeMode(ThemeMode newMode) async {
    try {
      themeMode = newMode;
      await _keyStorageService.setTheme(newMode.toString());
      _cachedThemeData = null;
    } catch (e) {
      log('Ошибка обновления режима темы: $e');
    }
  }

  @action
  Future<void> updateMainColor(Color newColor) async {
    try {
      mainColorConfig = ColorGenerator.generateColors(newColor);
      await _keyStorageService.setPrimaryColor(newColor.value);
      _cachedThemeData = null;
    } catch (e) {
      log('Ошибка обновления основного цвета: $e');
    }
  }

  @action
  void listenToSystemThemeChanges() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        () {
      if (themeMode == ThemeMode.system) {
        themeMode =
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                    Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light;
      }
    };
  }
}

/// Конфигурации стилей темы
enum ThemeStyleConfig {
  auto,
  light,
  dark,
  lightAccent,
  darkAccent,
}
