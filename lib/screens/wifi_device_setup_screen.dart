import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smarty_hub/utils/app_colors.dart';
import 'package:smarty_hub/utils/app_strings.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../controllers/theme_controller.dart';
import '../controllers/wifi_device_setup_controller.dart';


class WifiScanPage extends StatelessWidget {
  final WifiController wifiController = Get.put(WifiController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(themeController.currentBackgroundImage.value),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
                          onPressed: () {
                            wifiController.stopScan();
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          AppStrings.deviceSetupTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).iconTheme.color,
                              ),
                        ),
                        Spacer(),
                        if (wifiController.isScanning.value && wifiController.isWifiEnabled.value)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.orange),
                              ),
                            ),
                          )
                        else if (wifiController.isWifiEnabled.value)
                          IconButton(
                            icon: Icon(Icons.refresh, color: Theme.of(context).iconTheme.color),
                            onPressed: wifiController.clearNetworksAndScan,
                          ),
                      ],
                    ),
                    if (wifiController.isWifiEnabled.value)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          AppStrings.wifiDescription,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    SizedBox(height: 24),
                    if (!wifiController.isWifiEnabled.value)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Wi-Fi is inactive.',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: wifiController.promptEnableWifi,
                              child: Text('Enable Wi-Fi'),
                            ),
                          ],
                        ),
                      )
                    else if (wifiController.wifiNetworks.isEmpty && !wifiController.isScanning.value)
                      Center(
                        child: Text(
                          'No networks detected.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                      ),
                    if (wifiController.isWifiEnabled.value)
                      Expanded(
                        child: Obx(
                          () => ListView.builder(
                            itemCount: wifiController.wifiNetworks.length,
                            itemBuilder: (context, index) {
                              WifiNetwork network = wifiController.wifiNetworks[index];
                              int level = network.level ?? -100;
                              return ListTile(selectedColor: AppColors.orange,
                                trailing: Icon(wifiController.getSignalIcon(level)),
                                title: Text(network.ssid ?? 'Unknown'),
                                onTap: () {
                                  wifiController.selectedNetwork.value = network;
                                  wifiController.checkSignal();
                                },
                                selected: wifiController.selectedNetwork.value == network,
                              );
                            },
                          ),
                        ),
                      ),
                    if (wifiController.warningMessage.value.isNotEmpty && wifiController.isWifiEnabled.value)
                      Obx(() => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                              wifiController.warningMessage.value,
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                      )),
                    if (wifiController.isWifiEnabled.value)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: wifiController.selectedNetwork.value != null
                              ? wifiController.connectToNetwork
                              : null,
                          icon: Icon(
                            Icons.arrow_forward,
                            color: wifiController.selectedNetwork.value != null
                                ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                                : Colors.grey,
                          ),
        iconAlignment: IconAlignment.end,
                          label: Text(
                            'Next',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: wifiController.selectedNetwork.value != null
                                      ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                                      : Colors.grey,
                                ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}