// lib/core/services/preferences_service.dart
import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService { 
 
  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
 

  Future<bool?> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedin');
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedin', isLoggedIn);
  }

 Future<bool?> getisDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkTheme');
  }

  Future<void> setisDarkTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkTheme);
  }
  // ignore: non_constant_identifier_names
  Future<void> clearPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
    Future<void> saveBackgroundImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('backgroundImage', path);
  }

  Future<String?> getBackgroundImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('backgroundImage');
  }
}
