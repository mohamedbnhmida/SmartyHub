import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ThemeController extends GetxController {
  var isDarkTheme = false.obs;
  var currentBackgroundImage = 'assets/backgrounds/bg0.png'.obs;
  var hoverIndex = (-1).obs; // Track the hover index

  ThemeMode get theme => isDarkTheme.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
    _loadBackgroundFromPrefs();
  }

  void toggleTheme(bool isDark) {
    isDarkTheme.value = isDark;
    _saveThemeToPrefs(isDark);
  }

  void setBackgroundImage(String path) {
    currentBackgroundImage.value = path;
    _saveBackgroundToPrefs(path);
  }

  void setHoverIndex(int index) {
    hoverIndex.value = index;
  }

  void clearHoverIndex() {
    hoverIndex.value = -1;
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkTheme.value = prefs.getBool('isDarkTheme') ?? false;
  }

  Future<void> _saveThemeToPrefs(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkTheme);
  }

  Future<void> _loadBackgroundFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    currentBackgroundImage.value = prefs.getString('backgroundImage') ?? 'assets/backgrounds/bg0.png';
  }

  Future<void> _saveBackgroundToPrefs(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('backgroundImage', path);
  }
}