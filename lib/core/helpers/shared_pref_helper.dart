import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/features/auth/data/model/user_model.dart';

class SharedPrefsHelper {
  static late final SharedPreferences prefs;
  static bool _isPrefInitialized = false;

  static Future<void> init() async {
    if (_isPrefInitialized) {
      return;
    }
    prefs = await SharedPreferences.getInstance().then((value) async {
      _isPrefInitialized = true;
      return value;
    });
    // if (!SharedPrefsHelper.isContainsDeviceData()) {}
  }

  // Keys
  static const String _isOnboardingViewedKey = '_isOnboardingViewedKey';
  static const String _appLanguageKey = '_appLanguageKey';
  static const String _isDarkModeKey = '_isDarkModeKey';
  static const String _tokenKey = '_tokenKey';
  static const String _userKey = '_userKey';

  static Future<void> setOnboardingViewed(bool isViewed) async {
    await prefs.setBool(_isOnboardingViewedKey, isViewed);
  }

  static bool isOnboardingViewed() {
    return prefs.getBool(_isOnboardingViewedKey) ?? false;
  }

  static Future<void> setLanguageSuffix(String languageCode) async {
    await prefs.setString(_appLanguageKey, languageCode);
  }

  static String getLanguageSuffix() {
    if (!prefs.containsKey(_appLanguageKey)) {
      setLanguageSuffix('en');
      return 'en';
    }
    return prefs.getString(_appLanguageKey) ?? 'en';
  }

  static Future<void> setIsDarkMode(bool isDarkMode) async {
    await prefs.setBool(_isDarkModeKey, isDarkMode);
  }

  static bool getIsDarkMode() {
    if (!prefs.containsKey(_isDarkModeKey)) {
      bool isDark = false;
      // (PlatformDispatcher.instance.platformBrightness == Brightness.dark);
      setIsDarkMode(isDark);
      return isDark;
    }
    return prefs.getBool(_isDarkModeKey) ??
        (PlatformDispatcher.instance.platformBrightness == Brightness.dark);
  }

  static String? getToken() {
    return prefs.getString(_tokenKey);
  }

  static Future<bool> setToken({required String value}) async {
    return prefs.setString(_tokenKey, value);
  }

  static bool isLoggedIn() {
    return prefs.containsKey(_userKey);
  }

  static Future<void> setUserModel(UserModel user) async {
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  static UserModel? getUserModel() {
    if (!isLoggedIn()) {
      return null;
    }
    final String? versionControlJson = prefs.getString(_userKey);
    if (versionControlJson == null) return null;
    return UserModel.fromJson(jsonDecode(versionControlJson));
  }

  static Future<void> logOut() async {
    await prefs.remove(_userKey);
    await prefs.remove(_tokenKey);
  }
}
