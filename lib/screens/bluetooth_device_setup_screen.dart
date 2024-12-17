
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smarty_hub/utils/app_colors.dart';
import 'package:smarty_hub/utils/app_padding.dart';

import '../controllers/bluetooth_device_setup_controller.dart';
import '../controllers/theme_controller.dart';
import '../utils/app_strings.dart';
import '../widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothPage extends StatelessWidget {
  final BluetoothController bluetoothController = Get.put(BluetoothController());
  final ThemeController themecontroller = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
                   Obx(() => Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage(
                          themecontroller.currentBackgroundImage.value),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
                        onPressed: () {
                          bluetoothController.stopScan();
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        AppStrings.deviceSetup,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      Spacer(),
                      // Show circular progress indicator while scanning
                      if (bluetoothController.isScanning.value && bluetoothController.isBluetoothEnabled.value && !bluetoothController.isConnecting.value)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(height: 15,width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange),
                              ),
                            ),
                          )
                         
                      else if (bluetoothController.isBluetoothEnabled.value && !bluetoothController.isConnecting.value)
                        IconButton(
                          icon: Icon(Icons.refresh, color: Theme.of(context).iconTheme.color),
                          onPressed: bluetoothController.clearDevicesAndScan, // Clear and rescan on refresh
                        ),
                    ],
                  ),
                  if (bluetoothController.isBluetoothEnabled.value)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        AppStrings.searchForDevices,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  SizedBox(height: 24),
                  if (!bluetoothController.isBluetoothEnabled.value)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.bluetoothInactive,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: bluetoothController.promptEnableBluetooth,
                            child: Text(AppStrings.enableBluetooth),
                          ),
                        ],
                      ),
                    )
                  else if (bluetoothController.devices.isEmpty && !bluetoothController.isScanning.value)
                    Center(
                      child: Text(
                        AppStrings.noDevicesDetected,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                    ),
                    if (bluetoothController.isBluetoothEnabled.value)   
                  Expanded(
                    child: Obx(() => ListView.builder(
                      itemCount: bluetoothController.devices.length,
                      itemBuilder: (context, index) {
                        BluetoothDevice device = bluetoothController.devices[index];
                        String? deviceName = device.name?.trim();
                        String? displayName = deviceName?.isNotEmpty ?? false ? deviceName : 'Unknown Device';
                        String macAddress = device.address;

                                            return Obx(() => ListTile(
                          title: Text('$displayName\n$macAddress'),
                          onTap: bluetoothController.isConnecting.value
                              ? null // Disable tap if connecting
                              : () {
                                  bluetoothController.selectedDevice.value = device; // Set selected device
                                },
                          selectedColor: AppColors.orange,
                          selected: bluetoothController.selectedDevice.value?.address == device.address,
                          enabled: !bluetoothController.isConnecting.value, // Disable the ListTile if connecting
                        ));
                                              },
                    )),
                  ),
                  if (bluetoothController.isBluetoothEnabled.value)
                Align(
  alignment: Alignment.centerRight,
  child: Obx(() {
    if (bluetoothController.isConnecting.value) {
      return Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.orange,
            ),
          ),
        ),
      );
    } else {
      return TextButton.icon(
        onPressed: bluetoothController.selectedDevice.value != null
            ? bluetoothController.connectToDevice
            : null,
        icon: Icon(
          Icons.arrow_forward,
          color: bluetoothController.selectedDevice.value != null
              ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
              : Colors.grey,
        ),
        iconAlignment: IconAlignment.end,
        label: Text(
          'Next',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: bluetoothController.selectedDevice.value != null
                ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                : Colors.grey,
          ),
        ),
      );
    }
  }),
),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}