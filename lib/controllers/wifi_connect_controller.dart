import 'package:android_flutter_wifi/android_flutter_wifi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';



class WifiConnectController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  var obscurePassword = true.obs;
  var isConnecting = false.obs;
  var isConnected = false.obs;
  var connectionErrorMessage = ''.obs; 

  static const platform = MethodChannel('com.example.smarty_hub/wifi');

  Future<void> connectToWifi(String ssid, String password) async {
    isConnecting.value = true; // Start loading
    connectionErrorMessage.value = ''; // Reset error message

    try {
      final result = await platform.invokeMethod('connectToWifi', {
        'ssid': ssid,
        'password': password,
      });
      print(result); // Successfully connected message
      isConnected.value = true; // Update connection status
    } on PlatformException catch (e) {
      print("Failed to connect to Wi-Fi: ${e.message}");
      connectionErrorMessage.value = e.message ?? 'Unknown error occurred'; // Update error message
    } finally {
      isConnecting.value = false; // Stop loading
    }
  }
}