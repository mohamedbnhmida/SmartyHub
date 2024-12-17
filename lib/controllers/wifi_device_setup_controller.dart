 import 'dart:async'; 
 import 'package:flutter/material.dart';
 import 'package:get/get.dart'; 
import 'package:wifi_iot/wifi_iot.dart';
import 'package:permission_handler/permission_handler.dart';
 
import '../screens/wifi_connect_page.dart';
class WifiController extends GetxController {
  // Observables
  var wifiNetworks = <WifiNetwork>[].obs;
  var selectedNetwork = Rx<WifiNetwork?>(null);
  var isScanning = false.obs;
  var isWifiEnabled = false.obs;
  var warningMessage = ''.obs;
  var isConnecting = false.obs;
  var isConnected = false.obs;
    var obscurePassword = true.obs;
  
  var connectionErrorMessage = ' '.obs;

  // Controller for password input
  final passwordController = TextEditingController(text: "");

  // Timer for scanning
  Timer? _scanTimer;

  @override
  void onInit() {
    super.onInit();
    _initWifi();
    _monitorWifiState(); // Monitor Wi-Fi state periodically
     passwordController.text = "";
      connectionErrorMessage.value =" ";
      
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    connectionErrorMessage.value =" ";
  }
  // Initialize Wi-Fi and check status
  void _initWifi() async {
    await _checkWifiStatus();
  }

  // Method to check and update the Wi-Fi status
  Future<void> _checkWifiStatus() async {
    bool isEnabled = await WiFiForIoTPlugin.isEnabled();
    isWifiEnabled.value = isEnabled;
    if (isEnabled) {
      checkAndStartScan();
    }
  }

  // Periodically checks Wi-Fi state to update UI
  void _monitorWifiState() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      bool isEnabled = await WiFiForIoTPlugin.isEnabled();
     
      if (isEnabled != isWifiEnabled.value) {
        isWifiEnabled.value = isEnabled;
        if (isEnabled) {
          clearNetworksAndScan(); // Start scanning when Wi-Fi is enabled
        } else {
          wifiNetworks.clear(); // Clear networks if Wi-Fi is disabled
          warningMessage.value = '';
        }
      }
    });
  }

  // Prompt user to enable Wi-Fi if it's disabled
  Future<void> promptEnableWifi() async {
    await WiFiForIoTPlugin.setEnabled(true, shouldOpenSettings: true);
    clearNetworksAndScan();
  }

  // Request location permission and start Wi-Fi scan
  Future<void> checkAndStartScan() async {
    if (await Permission.location.isGranted) {
      startScan();
    } else {
      await requestLocationPermission();
    }
  }

  // Request location permission for scanning Wi-Fi networks
  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      startScan();
    } else {
      print('Location permission denied');
    }
  }

  // Clear existing networks and start scanning
  Future<void> clearNetworksAndScan() async {
    wifiNetworks.clear();
    selectedNetwork.value = null;
    warningMessage.value = '';
    await startScan();
  }

  // Start scanning for Wi-Fi networks
  Future<void> startScan() async {
    isScanning.value = true;

    List<WifiNetwork?>? networks = await WiFiForIoTPlugin.loadWifiList();
    if (networks != null) {
      // Filter out null values and sort by signal strength (RSSI)
      wifiNetworks.value = networks
          .whereType<WifiNetwork>()
          .toList()
        ..sort((a, b) => b.level!.compareTo(a.level!));
    }

    isScanning.value = false;
    _scanTimer = Timer(Duration(seconds: 20), stopScan);
  }

  // Stop scanning for Wi-Fi networks
  void stopScan() {
    _scanTimer?.cancel();
    _scanTimer = null;
    isScanning.value = false;
  }

  // Check signal strength of the selected network and update the warning message
  Future<void> checkSignal() async {
    if (selectedNetwork.value != null) {
      int signalLevel = selectedNetwork.value!.level ?? -100;
      print(signalLevel);

      // Check signal strength and set warning message
      if (signalLevel < -80) { // Threshold for low signal
        warningMessage.value =
            'The signal strength for ${selectedNetwork.value?.ssid} is weak. You may experience connectivity issues.';
      } else {
        warningMessage.value = ''; // Clear the message if the signal is sufficient
      }
    }
  }

  // Navigate to the Wi-Fi connection page to input the password
  Future<void> connectToNetwork() async {
     passwordController.text = "";
      connectionErrorMessage.value =" ";
    if (selectedNetwork.value != null) {
      print('Connecting to ${selectedNetwork.value?.ssid}');
      Get.to(() => WifiConnectionPage(ssid: selectedNetwork.value!.ssid ?? 'Unknown'));
    } else {
      print('No network selected.');
      Get.snackbar('Error', 'Please select a Wi-Fi network to connect to.'); // Inform user
    }
  }

  
  // Get the appropriate signal icon based on the Wi-Fi signal strength
  IconData getSignalIcon(int level) {
    if (level >= -60) {
      return Icons.wifi; // Strong signal
    } else if (level >= -80) {
      return Icons.wifi_2_bar; // Medium signal
    } else {
      return Icons.wifi_1_bar; // Weak signal
    }
  }
}
