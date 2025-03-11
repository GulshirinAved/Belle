// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeController on _ThemeControllerBase, Store {
  late final _$mainColorConfigAtom =
      Atom(name: '_ThemeControllerBase.mainColorConfig', context: context);

  @override
  MainColorConfig get mainColorConfig {
    _$mainColorConfigAtom.reportRead();
    return super.mainColorConfig;
  }

  @override
  set mainColorConfig(MainColorConfig value) {
    _$mainColorConfigAtom.reportWrite(value, super.mainColorConfig, () {
      super.mainColorConfig = value;
    });
  }

  late final _$themeModeAtom =
      Atom(name: '_ThemeControllerBase.themeMode', context: context);

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$_cachedThemeDataAtom =
      Atom(name: '_ThemeControllerBase._cachedThemeData', context: context);

  @override
  ThemeData? get _cachedThemeData {
    _$_cachedThemeDataAtom.reportRead();
    return super._cachedThemeData;
  }

  @override
  set _cachedThemeData(ThemeData? value) {
    _$_cachedThemeDataAtom.reportWrite(value, super._cachedThemeData, () {
      super._cachedThemeData = value;
    });
  }

  late final _$fetchThemeAsyncAction =
      AsyncAction('_ThemeControllerBase.fetchTheme', context: context);

  @override
  Future<void> fetchTheme() {
    return _$fetchThemeAsyncAction.run(() => super.fetchTheme());
  }

  late final _$updateThemeModeAsyncAction =
      AsyncAction('_ThemeControllerBase.updateThemeMode', context: context);

  @override
  Future<void> updateThemeMode(ThemeMode newMode) {
    return _$updateThemeModeAsyncAction
        .run(() => super.updateThemeMode(newMode));
  }

  late final _$updateMainColorAsyncAction =
      AsyncAction('_ThemeControllerBase.updateMainColor', context: context);

  @override
  Future<void> updateMainColor(Color newColor) {
    return _$updateMainColorAsyncAction
        .run(() => super.updateMainColor(newColor));
  }

  late final _$_ThemeControllerBaseActionController =
      ActionController(name: '_ThemeControllerBase', context: context);

  @override
  void listenToSystemThemeChanges() {
    final _$actionInfo = _$_ThemeControllerBaseActionController.startAction(
        name: '_ThemeControllerBase.listenToSystemThemeChanges');
    try {
      return super.listenToSystemThemeChanges();
    } finally {
      _$_ThemeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mainColorConfig: ${mainColorConfig},
themeMode: ${themeMode}
    ''';
  }
}
