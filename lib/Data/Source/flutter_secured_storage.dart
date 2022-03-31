import 'package:default_repo_app/Data/Source/local_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DefaultSecuredStorage {
  static const _securedStorage = FlutterSecureStorage();



  /// SETTERS
  static Future setIsFirstUse(String firstUse) async {
    await _securedStorage.write(key: DbKeys.isFirstUse , value: firstUse);
  }

  static Future setIsLogged(String isLogged) async {
    await _securedStorage.write(key: DbKeys.isLogged, value: isLogged);
  }

  static Future setUserName(String userName) async {
    await _securedStorage.write(key: DbKeys.userName, value: userName);
  }

  static Future setPassword(String password) async {
    await _securedStorage.write(key: DbKeys.password, value: password);
  }

  static Future setUserMap(String? userMap) async {
    await _securedStorage.write(key: DbKeys.userMap, value: userMap);
  }

  static Future setAccessToken(String? token) async {
    await _securedStorage.write(key: DbKeys.token, value: token);
  }

  static void setLang(String lang) async {
    await _securedStorage.write(key: DbKeys.lang, value: lang);
  }

  static void setCountryCode(String countryCode) async {
    await _securedStorage.write(key: DbKeys.countryCode, value: countryCode);
  }

  static void setDoctorMap(String doctorMap) async {
    await _securedStorage.write(key: DbKeys.countryCode, value: doctorMap);
  }

  /// GETTERS
  ///
  static Future<String?> getIsFirstUse() async {
    return await _securedStorage.read(key: DbKeys.isFirstUse);
  }

  static Future<String?> getIsLogged() async {
    return await _securedStorage.read(key: DbKeys.isLogged);
  }

  static Future<String?> getUserName() async {
    return await _securedStorage.read(key: DbKeys.userName);
  }

  static Future<String?> getPassword() async {
    return await _securedStorage.read(key: DbKeys.password);
  }

  static Future<String?> getUserMap() async {
    return await _securedStorage.read(key: DbKeys.userMap);
  }

  static Future<String?> getAccessToken() async {
    return await _securedStorage.read(key:DbKeys.token);
  }

  static Future<String?> getLang() async {
    return await _securedStorage.read(key:DbKeys.lang);
  }

  static Future<String?> getCountryCode() async {
    return await _securedStorage.read(key: DbKeys.countryCode);
  }
}
