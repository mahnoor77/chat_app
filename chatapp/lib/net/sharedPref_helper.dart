import 'package:shared_preferences/shared_preferences.dart';

class sharedPreferenceHelper {
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userDisplayNameKey = "USERDISPLAYNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userProfileKey = "USERPROFILEKEY";

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveDisplayName(String getDisplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userDisplayNameKey, getDisplayName);
  }

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserProfile(String getUserProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfileKey, getUserProfile);
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = prefs.getString(userNameKey) ?? "";
    return response;
  }

  static Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = prefs.getString(userEmailKey) ?? "";
    return response;
  }

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = prefs.getString(userIdKey) ?? "";
    return response;
  }

  static Future<String> getUserProfle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = prefs.getString(userProfileKey) ?? "";
    return response;
  }

  static Future<String> getUserDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = prefs.getString(userDisplayNameKey) ?? "";
    return response;
  }
}
