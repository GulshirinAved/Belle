// Services

import 'dart:developer';

// import 'package:sportportal_food/src/features/account_info/data/account_info.dart';

// import '../../features/auth/data/dto/account_dto.dart';
// import '../../features/account/data/dto/account_dto.dart';

import 'key_value_storage_base.dart';

/// A service class for providing methods to store and retrieve key-value data
/// from common or secure storage.
class KeyValueStorageService {
  static const _isFirstOpen = 'isFirstOpen';

  /// The name of auth token key
  static const _authTokenKey = 'authToken';
  /// The name of auth token key
  static const _refreshTokenKey = 'refreshToken';

  /// The name of auth token key
  static const _fcmTokenKey = 'fcmToken';

  /// The name of user model key
  // static const _authUserKey = 'authUserKey';

  /// The
  static const _localizationKey = 'localizationKey';

  static const _themeKey = 'themeKey';

  static const _primaryColor = 'primaryColor';

  static const _masterTypeIdKey = 'masterTypeIdKey';

  /// Instance of key-value storage base class
  final _keyValueStorage = KeyValueStorageBase();

  KeyValueStorageService();

  Future<void> setValue<T>(String key, T value) async {
    await _keyValueStorage.setCommon(key, value);
  }

  T? getValue<T>(String key) {
    return _keyValueStorage.getCommon<T>(key);
  }

  Future<void> setTheme(String locale) async {
    await _keyValueStorage.setCommon<String>(_themeKey, locale);
  }

  String? getTheme() {
    return _keyValueStorage.getCommon<String>(_themeKey);
  }

  Future<void> setPrimaryColor(int value) async {
    await _keyValueStorage.setCommon<int>(_primaryColor, value);
  }

  int? getPrimaryColor() {
    return _keyValueStorage.getCommon<int>(_primaryColor);
  }

  Future<void> setLocale(String locale) async {
    await _keyValueStorage.setCommon<String>(_localizationKey, locale);
  }

  Future<void> setMasterTypeId(int id) async {
    await _keyValueStorage.setCommon<int>(_masterTypeIdKey, id);
  }

  int getMasterTypeId() {
    return _keyValueStorage.getCommon<int>(_masterTypeIdKey) ?? 1;
  }

  String? getLocale() {
    return _keyValueStorage.getCommon<String>(_localizationKey);
  }

  Future<void> setFirstOpen(bool value) async {
    await _keyValueStorage.setCommon<bool>(_isFirstOpen, value);
  }

  bool? getFirstOpen() {
    return _keyValueStorage.getCommon<bool>(_isFirstOpen);
  }

  /// Returns last authentication token
  Future<String> getAuthToken() async {
    return await _keyValueStorage.getEncrypted(_authTokenKey) ?? '';
  }
  /// Returns last authentication token
  Future<String> getRefreshToken() async {
    return await _keyValueStorage.getEncrypted(_refreshTokenKey) ?? '';
  }

  /// Returns last authentication token
  Future<String> getFCMToken() async {
    return await _keyValueStorage.getEncrypted(_fcmTokenKey) ?? '';
  }

  /// Sets the authentication token to this value
  Future<void> setAuthToken(String token) async {
    log('new token was saved! $token');
    await _keyValueStorage.setEncrypted(_authTokenKey, token);
  }
  /// Sets the authentication token to this value
  Future<void> setRefreshToken(String token) async {
    log('new token was saved! $token');
    await _keyValueStorage.setEncrypted(_refreshTokenKey, token);
  }

  /// Sets the authentication token to this value
  Future<void> setFcmToken(String token) async {
    log('new token was saved! $token');
    await _keyValueStorage.setEncrypted(_fcmTokenKey, token);
  }

  Future<void> resetAuthToken() async {
    await _keyValueStorage.clearEncryptedKey(_authTokenKey);
  }
  Future<void> resetRefreshToken() async {
    await _keyValueStorage.clearEncryptedKey(_refreshTokenKey);
  }

  Future<void> resetFcmToken() async {
    await _keyValueStorage.clearEncryptedKey(_fcmTokenKey);
  }

  /// Resets the authentication. Even though these methods are asynchronous, we
  /// don't care about their completion which is why we don't use `await` and
  /// let them execute in the background.
  void resetKeys() {
    _keyValueStorage
      ..clearCommon()
      ..clearEncrypted();
  }
}
