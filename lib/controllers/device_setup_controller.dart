 
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class DeviceSetupController extends GetxController {
  var devices = <BluetoothDevice>[].obs;
  var isScanning = false.obs;

  void startScan() {
    isScanning.value = true;
    // Scan for devices using flutter_bluetooth_serial
    // BluetoothSerial.instance.startDiscovery().listen((r) {
    //   devices.add(r.device);
    // }).onDone(() {
    //   isScanning.value = false;
    // });
     isScanning.value = false;
  }

  void connectToDevice(BluetoothDevice device) {
    // Logic to connect to the device
    // Once connected, navigate to the next screen to configure Wi-Fi credentials
  }
}