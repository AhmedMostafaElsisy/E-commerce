import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DefaultSecuredStorage {
  static const _securedStorage = FlutterSecureStorage();

  /// KEYS
  static const String _isFirstUse = 'isFirstUse';
  static const String _isLogged = 'isLogged';
  static const String _userName = 'userName';
  static const String _password = 'password';
  static const String _userMap = 'userMap';
  static const String _token = 'token';
  static const String _lang = 'lang';
  static const String _countryCode = 'countryCode';

  /// SETTERS
  static Future setIsFirstUse(String firstUse) async {
    await _securedStorage.write(key: _isFirstUse, value: firstUse);
  }

  static Future setIsLogged(String isLogged) async {
    await _securedStorage.write(key: _isLogged, value: isLogged);
  }

  static Future setUserName(String userName) async {
    await _securedStorage.write(key: _userName, value: userName);
  }

  static Future setPassword(String password) async {
    await _securedStorage.write(key: _password, value: password);
  }

  static Future setUserMap(String? userMap) async {
    await _securedStorage.write(key: _userMap, value: userMap);
  }

  static Future setAccessToken(String? token) async {
    await _securedStorage.write(key: _token, value: token);
  }

  static void setLang(String lang) async {
    await _securedStorage.write(key: _lang, value: lang);
  }

  static void setCountryCode(String countryCode) async {
    await _securedStorage.write(key: _countryCode, value: countryCode);
  }

  static void setDoctorMap(String doctorMap) async {
    await _securedStorage.write(key: _countryCode, value: doctorMap);
  }

  /// GETTERS
  ///
  static Future<String?> getIsFirstUse() async {
    return await _securedStorage.read(key: _isFirstUse);
  }

  static Future<String?> getIsLogged() async {
    return await _securedStorage.read(key: _isLogged);
  }

  static Future<String?> getUserName() async {
    return await _securedStorage.read(key: _userName);
  }

  static Future<String?> getPassword() async {
    return await _securedStorage.read(key: _password);
  }

  static Future<String?> getUserMap() async {
    return await _securedStorage.read(key: _userMap);
  }

  static Future<String?> getAccessToken() async {
    return await _securedStorage.read(key: _token);
  }

  static Future<String?> getLang() async {
    return await _securedStorage.read(key: _lang);
  }

  static Future<String?> getCountryCode() async {
    return await _securedStorage.read(key: _countryCode);
  }
}
