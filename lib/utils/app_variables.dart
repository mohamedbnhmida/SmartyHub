// Classe contenant tous les variables globales de l'application

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class AppVariables {
  static String authToken = '';
  static bool isLoggedIn = false; 
  static String refreshToken = '';
  static BluetoothDevice? selectedBTDevice = null;

}
