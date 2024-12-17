import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smarty_hub/controllers/wifi_connect_controller.dart';
import 'package:smarty_hub/screens/device_name_room_setup_screen.dart';
import 'package:smarty_hub/utils/app_padding.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../controllers/theme_controller.dart';
import '../controllers/wifi_device_setup_controller.dart'; 



class WifiConnectionPage extends StatelessWidget {
  final WifiConnectController wifiController = Get.put(WifiConnectController());
  final String ssid;

  WifiConnectionPage({Key? key, required this.ssid}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(() => Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(
                        themeController.currentBackgroundImage.value),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: Theme.of(context).iconTheme.color),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      Text(
                        AppStrings.deviceSetup,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).iconTheme.color,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Connect to $ssid',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter Wi-Fi Password:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 10),
                  Obx(() => TextFormField(
                        controller: wifiController.passwordController,
                        obscureText: wifiController.obscurePassword.value,
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            AppAssets.lockIcon,
                            height: 16,
                            width: 20,
                            fit: BoxFit.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              wifiController.obscurePassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              wifiController.obscurePassword.value =
                                  !wifiController.obscurePassword.value;
                            },
                          ),
                          hintText: AppStrings.passwordHint,
                        ),
                      )),
                  AppPadding.paddingH24,
                  Obx(() {
                    if (wifiController.isConnecting.value) {
                      return Center(
                        child: CircularProgressIndicator(color: AppColors.orange),
                      );
                    } else {
                      return Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            String password = wifiController.passwordController.text;
                            wifiController.connectToWifi(ssid, password);
                          },
                          icon: Icon(Icons.wifi),
                          label: Text('Connect'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          ),
                        ),
                      );
                    }
                  }),
                  SizedBox(height: 20),
                  Obx(() {
                    if (wifiController.isConnected.value) {
                      return Text(
                        'Connected to $ssid',
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      );
                    } else if (wifiController.connectionErrorMessage.value.isNotEmpty) {
                      return Text(
                        wifiController.connectionErrorMessage.value,
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      );
                    } else {
                      return Container();
                    }
                  }),
                  Spacer(),
                  Obx(() => Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: wifiController.isConnected.value
                            ? () {
                                Get.to(DeviceSetupPage());
                              }
                            : null,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: wifiController.isConnected.value
                              ? Theme.of(context).iconTheme.color
                              : Colors.grey,
                        ),
                        label: Text(
                          'Next',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: wifiController.isConnected.value
                                    ? Theme.of(context).iconTheme.color
                                    : Colors.grey,
                              ),
                        ),
                      )))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}