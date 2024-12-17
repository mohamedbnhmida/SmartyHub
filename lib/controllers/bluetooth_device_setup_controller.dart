import 'dart:async';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smarty_hub/utils/app_helpers.dart';
import 'package:smarty_hub/utils/app_variables.dart';

import '../utils/app_routes.dart';
class BluetoothController extends GetxController {
  final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  var devices = <BluetoothDevice>[].obs; // Observable list of devices
  var selectedDevice = Rx<BluetoothDevice?>(null);
  var isScanning = false.obs;
  var isBluetoothEnabled = false.obs;
  Stream<bool>? _bluetoothStateStream;
  Timer? _scanTimer;
  var isConnecting = false.obs; // Add this line

  @override
  void onInit() {
    super.onInit();
    _bluetooth.cancelDiscovery();
    _initBluetooth();
    
  }

  void _initBluetooth() {
    _checkBluetooth();

    // Listen for Bluetooth state changes
    _bluetoothStateStream = _bluetooth.onStateChanged().map((state) => state == BluetoothState.STATE_ON);
    _bluetoothStateStream!.listen((isEnabled) {
      isBluetoothEnabled.value = isEnabled;
      if (isEnabled) {
        clearDevicesAndScan(); // Clear devices and rescan
      }
    });
  }

  Future<void> _checkBluetooth() async {
    bool? isEnabled = await _bluetooth.isEnabled;
    isBluetoothEnabled.value = isEnabled!;
    if (isEnabled) {
      checkAndStartScan();
    }
  }

  Future<void> promptEnableBluetooth() async {
    await _bluetooth.requestEnable();
    clearDevicesAndScan(); // Clear devices and rescan on return
  }

  Future<void> checkAndStartScan() async {
    if (await Permission.bluetooth.isGranted &&
        await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothConnect.isGranted) {
      startScan();
    } else {
      await requestBluetoothPermissions();
    }
  }

  Future<void> requestBluetoothPermissions() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();

    if (status[Permission.bluetooth] == PermissionStatus.granted &&
        status[Permission.bluetoothScan] == PermissionStatus.granted &&
        status[Permission.bluetoothConnect] == PermissionStatus.granted) {
      startScan();
    } else {
      print('Bluetooth permissions denied');
    }
  }

  Future<void> clearDevicesAndScan() async {
    devices.clear(); // Clear the list of devices
    selectedDevice.value = null; // Reset the selected device
    await startScan(); // Start scanning for devices
  }

  Future<void> startScan() async {
    isScanning.value = true; // Set scanning state to true

    final discoveredDevices = <BluetoothDevice>{}; // Use a Set to track unique devices
    final seenAddresses = <String>{}; // Track seen MAC addresses

    _bluetooth.startDiscovery().listen((BluetoothDiscoveryResult result) {
      // Only add device if its MAC address has not been seen before
      if (seenAddresses.add(result.device.address)) {
        discoveredDevices.add(result.device);
        devices.add(result.device); // Add discovered device to the observable list
      }
    }, onDone: () {
      stopScan(); // Stop scanning when done
    });

    // Start the timer to stop scanning after the specified duration
    _scanTimer = Timer(Duration(seconds: 20), () {
      stopScan(); // Stop scanning after 20 seconds
    });
  }

  void stopScan() {
    if (_scanTimer != null) {
      _scanTimer!.cancel(); // Cancel the timer
      _scanTimer = null; // Reset the timer
    }
    isScanning.value = false; // Set scanning state to false 
  }

  Future<void> connectToDevice() async {
    if (selectedDevice.value != null) {
        isConnecting.value = true; // Set connecting state to true
      try {
        final BluetoothConnection connection = await BluetoothConnection.toAddress(selectedDevice.value!.address);
        print('Connected to the device: ${selectedDevice.value!.name}');
        AppVariables.selectedBTDevice = selectedDevice.value;
        // Navigate to the next page or show a success message
        Get.toNamed(AppRoutes.devideWifiSetup); // Change the route as needed

      } catch (e) {
        print('Could not connect to device: $e');
        // Optionally show an error message
        showSnackbar('Connection Failed', 'Could not connect to ${selectedDevice.value!.name}. Please try again.' ,SnackbarType.error); 
      }finally{
         isConnecting.value = false; 
      }
    } else {
      print('No device selected.');
      // Optionally show a message indicating no device is selected
        showSnackbar('No Device Selected', 'Please select a device to connect.',SnackbarType.error); 
        } 
  }
}