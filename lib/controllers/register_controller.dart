import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
enum RegistrationStatus { idle, loading, success, error }

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
 

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var status = RegistrationStatus.idle.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  var isEmailValid = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void validateEmail(String email) {
    isEmailValid.value = GetUtils.isEmail(email);
  }

    
}
