import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarty_hub/utils/app_colors.dart';

import '../controllers/theme_controller.dart';
 import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

extension ToColorFilter on Color {
  ColorFilter? get toColorFilter {
    return ColorFilter.mode(this, BlendMode.srcIn);
  }
}

SnackPosition getSnackPosition() {
  if (Get.width > 1024) {
    return SnackPosition.TOP;
  } else if (Get.width <= 0) {
    return SnackPosition.BOTTOM; // Fallback position
  } else {
    return SnackPosition.BOTTOM;
  }
}

enum SnackbarType { error, success, warning, info }
 
void showSnackbar(String title, String message, SnackbarType type,
    {Duration duration = const Duration(seconds: 1)}) {
        final ThemeController controller = Get.find<ThemeController>();

  IconData iconData;
  Color snackBackgroundColor  = controller.isDarkTheme.value ? AppColors.bgSecondayDark:AppColors.bgLight;
  Color iconBackGroundColor ;
  Color textColor = controller.isDarkTheme.value ? Colors.white : Colors.black ;

  switch (type) {
    case SnackbarType.error:
      iconBackGroundColor = Colors.red;
      iconData = Icons.cancel_rounded;
      break;
    case SnackbarType.success:
      iconBackGroundColor = Colors.green;
      iconData = Icons.check_circle;
      break;

    case SnackbarType.warning:
      iconBackGroundColor = Colors.yellow;
      iconData = Icons.warning;
      break;
    case SnackbarType.info:
      iconBackGroundColor = Colors.blue;
      iconData = Icons.info;
      break;
  }

  Get.snackbar(
    title,
    message,
    backgroundColor: snackBackgroundColor,
    colorText: textColor,
    snackStyle: SnackStyle.FLOATING,
    borderRadius: 15,
    boxShadows: [
      BoxShadow(
        color: controller.isDarkTheme.value ? Colors.transparent:Colors.grey,
        blurRadius: 1,
        offset: const Offset(1, 1),
        spreadRadius: 0,
      )
    ],
    snackPosition: getSnackPosition(),
    maxWidth: 400,
    margin: const EdgeInsets.all(20),
    icon: Icon(
      iconData,
      color: iconBackGroundColor,
    ),
    duration: duration,
  );
}
 
class EncryptionUtil {
  final encrypt.Key key; // Define your encryption key
  final encrypt.IV iv;   // Define your initialization vector

  EncryptionUtil(String encryptionKey, String ivString)
      : key = encrypt.Key.fromUtf8(encryptionKey),
        iv = encrypt.IV.fromUtf8(ivString);

  String encryptCredentials(String ssid, String password) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt('$ssid:$password', iv: iv);
    return encrypted.base64; // Return the encrypted credentials in Base64 format
  }
}