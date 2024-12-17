import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_helpers.dart';
import 'preferences_service.dart'; 

class LoginController extends GetxController {
  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
 
  final PreferencesService preferencesService = Get.find<PreferencesService>();
 
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var status = LoginStatus.idle.obs;
  final RxBool obscurePassword = true.obs;
  var isEmailValid = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateEmail(String email) {
    isEmailValid.value = GetUtils.isEmail(email);
  }
 

  // Future<void> _saveLoginResponse() async {
  //   AppVariables.isLoggedIn = true;
  //   await preferencesService.saveUser(user.value!);
  //   await preferencesService.saveAuthToken(AppVariables.authToken);
  //   await preferencesService.saveRefreshToken(AppVariables.refreshToken);
  //   await preferencesService.setLoggedIn(true);
  // }

  // Future<void> logout() async {
  //   AppVariables.isLoggedIn = false;
  //   await preferencesService.clearPref();
  //   user.value = null;
  // }
}

enum LoginStatus { idle, loading, success, error }
