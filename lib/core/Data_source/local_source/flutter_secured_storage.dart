import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Keys/local_keys.dart';

class DefaultSecuredStorage {
  static late SharedPreferences _securedStorage;

  static initLocalStorage() async {
    _securedStorage = await SharedPreferences.getInstance();
  }

  /// SETTERS
  static Future setIsFirstUse(String firstUse) async {
    await _securedStorage.setString(DbKeys.isFirstUse, firstUse);
  }

  static Future setIsLogged(String isLogged) async {
    await _securedStorage.setString(DbKeys.isLogged, isLogged);
  }

  static Future setUserName(String userName) async {
    await _securedStorage.setString(DbKeys.userName, userName);
  }

  static Future setPassword(String password) async {
    await _securedStorage.setString(DbKeys.password, password);
  }

  static Future setUserMap(String userMap) async {
    await _securedStorage.setString(DbKeys.userMap, userMap);
  }

  static Future setAccessToken(String token) async {
    await _securedStorage.setString(DbKeys.token, token);
  }

  static Future setLang(String lang) async {
    await _securedStorage.setString(DbKeys.lang, lang);
  }

  static Future setCountryCode(String countryCode) async {
    await _securedStorage.setString(DbKeys.countryCode, countryCode);
  }

  static Future setDoctorMap(String doctorMap) async {
    await _securedStorage.setString(DbKeys.countryCode, doctorMap);
  }

  static Future setSettingMap(String settingMap) async {
    await _securedStorage.setString(DbKeys.settingKey, settingMap);
  }

  /// GETTERS
  ///
  static Future<String?> getIsFirstUse() async {
    return _securedStorage.getString(DbKeys.isFirstUse);
  }

  static Future<String?> getIsLogged() async {
    return _securedStorage.getString(DbKeys.isLogged);
  }

  static Future<String?> getUserName() async {
    return _securedStorage.getString(DbKeys.userName);
  }

  static Future<String?> getPassword() async {
    return _securedStorage.getString(DbKeys.password);
  }

  static Future<String?> getUserMap() async {
    return _securedStorage.getString(DbKeys.userMap);
  }

  static Future<String?> getAccessToken() async {
    return _securedStorage.getString(DbKeys.token);
  }

  static Future<String?> getLang() async {
    return _securedStorage.getString(DbKeys.lang);
  }

  static Future<String?> getCountryCode() async {
    return _securedStorage.getString(DbKeys.countryCode);
  }

  static Future<String?> getSetting() async {
    return _securedStorage.getString(DbKeys.settingKey);
  }

  ///remove key
  static Future removeUserMapFromCache() async {
    return _securedStorage.remove(DbKeys.userMap);
  }

  static Future removeAccessTokenFromCache() async {
    return _securedStorage.remove(DbKeys.token);
  }
}
