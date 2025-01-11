import 'package:get_storage/get_storage.dart';

class SharedPreferenceUtils {
  static GetStorage getStorage = GetStorage();

  static String language = 'language';
  static String langCode = 'langCode';
  static String langCodeId = 'langCodeId';
  static String isLogin = 'isLogin';
  static String token = "token";
  static String image = "Image";

  /// LANGUAGE CODE
  static Future setLanguageDes(String value) async {
    await getStorage.write(language, value);
  }

  static String getLanguageDes() {
    return getStorage.read(language) ?? "English";
  }

  /// LANG CODE
  static Future setLangCode(String value) async {
    await getStorage.write(langCode, value);
  }

  static String getLangCode() {
    return getStorage.read(langCode) ?? "";
  }

  /// is login
  static Future setIsLogin(bool value) async {
    await getStorage.write(isLogin, value);
  }

  static bool getIsLogin() {
    return getStorage.read(isLogin) ?? false;
  }

  static Future<void> clearPreference() async {
    await getStorage.erase();
  }

  ///token
  static Future setToken(String value) async {
    await getStorage.write(token, value);
  }

  static String getToken() {
    return getStorage.read(token)??"";
    }

   /// Image
  static Future setImage(String value) async {
    await getStorage.write(image, value);
  }
  static String getImage() {
    return getStorage.read(image)??"";
  }

}
