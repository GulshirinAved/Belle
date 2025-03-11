// ignore_for_file: library_private_types_in_public_api
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../core/core.dart';
import '../../../utils/utils.dart';

part 'language_controller.g.dart';

class LanguageController = _LanguageControllerBase with _$LanguageController;

abstract class _LanguageControllerBase with Store, HandlingErrorMixin {
  final _keyStorageService = KeyValueStorageService();

  // final _repository = GetIt.instance<LanguageRepository>();

  // @computed
  // bool get isLoading => _response.status == FutureStatus.pending;

  /// [locale] default value `const Locale('tk')`
  @readonly
  Locale _locale = const Locale('tk', 'TM');

  @computed
  String get localeCode => _locale.languageCode;

  // @observable
  // ObservableFuture<MetaWithDataResponse> _response =
  //     ObservableFuture.value(const MetaWithDataResponse());

  @action
  void fetchLocale() {
    try {
      String? savedLangCode = _keyStorageService.getLocale();
      _locale = savedLangCode == null
          ? const Locale('tk', 'TM')
          : Locale(savedLangCode);
    } catch (e) {
      _locale = const Locale('tk', 'TM');
      log(e.toString());
    }
  }

  @action
  void updateLocale(Locale newLocale) {
    try {
      String? savedLangCode = _keyStorageService.getLocale();
      if (savedLangCode != newLocale.languageCode) {
        _keyStorageService.setLocale(newLocale.languageCode);
        _locale = Locale(newLocale.languageCode);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // @action
  // Future<void> updateLocaleAndSendToServer(Locale newLocale) async {
  //   if (isLoading) {
  //     return;
  //   }
  //   try {
  //     String? savedLangCode = _keyStorageService.getLocale();
  //     Locale prevLocale = _locale;
  //     if (savedLangCode != newLocale.languageCode) {
  //       await _keyStorageService.setLocale(newLocale.languageCode);
  //       _locale = Locale(newLocale.languageCode);
  //       _sendLocaleToServer(prevLocale);
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
  //
  // @action
  // void _sendLocaleToServer(Locale prevLocale) {
  //   try {
  //     final locale = _locale.languageCode == 'tk' ? 'tm' : _locale.languageCode;
  //     final future = _repository.setLocale(locale);
  //     _response = ObservableFuture(future);
  //     _response.then((value) {
  //       handleSuccess(value.message ?? '');
  //     }).catchError((e) {
  //       updateLocale(prevLocale);
  //       handleError(e.toString());
  //       debugPrint(e.toString());
  //     });
  //   } catch (e) {
  //     handleError(e.toString());
  //     debugPrint(e.toString());
  //   }
  // }
}
