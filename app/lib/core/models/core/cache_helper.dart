import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // For firebase sign in
  static Future<bool> saveUserCode(String userCode) async {
    return await prefs.setString('userCode', userCode);
  }

  static String getSignInUserCode() {
    final result = prefs.getString('userCode');
    return result ?? '';
  }

  // For firebase sign in
  static Future<bool> saveTempFCMToken(String fcmToken) async {
    return await prefs.setString('tempFCMToken', fcmToken);
  }

  static String getTempFCMToken() {
    final result = prefs.getString('tempFCMToken');
    return result ?? '';
  }
}
