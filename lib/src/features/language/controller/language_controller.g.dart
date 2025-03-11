// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LanguageController on _LanguageControllerBase, Store {
  Computed<String>? _$localeCodeComputed;

  @override
  String get localeCode =>
      (_$localeCodeComputed ??= Computed<String>(() => super.localeCode,
              name: '_LanguageControllerBase.localeCode'))
          .value;

  late final _$_localeAtom =
      Atom(name: '_LanguageControllerBase._locale', context: context);

  Locale get locale {
    _$_localeAtom.reportRead();
    return super._locale;
  }

  @override
  Locale get _locale => locale;

  @override
  set _locale(Locale value) {
    _$_localeAtom.reportWrite(value, super._locale, () {
      super._locale = value;
    });
  }

  late final _$_LanguageControllerBaseActionController =
      ActionController(name: '_LanguageControllerBase', context: context);

  @override
  void fetchLocale() {
    final _$actionInfo = _$_LanguageControllerBaseActionController.startAction(
        name: '_LanguageControllerBase.fetchLocale');
    try {
      return super.fetchLocale();
    } finally {
      _$_LanguageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateLocale(Locale newLocale) {
    final _$actionInfo = _$_LanguageControllerBaseActionController.startAction(
        name: '_LanguageControllerBase.updateLocale');
    try {
      return super.updateLocale(newLocale);
    } finally {
      _$_LanguageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
localeCode: ${localeCode}
    ''';
  }
}
