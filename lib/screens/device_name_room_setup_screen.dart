import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarty_hub/utils/app_colors.dart';
import 'package:smarty_hub/utils/app_padding.dart';

import '../controllers/theme_controller.dart';
import '../controllers/wifi_device_setup_controller.dart';



class DeviceSetupPage extends StatelessWidget {
  final TextEditingController deviceNameController = TextEditingController();
  final TextEditingController newRoomController = TextEditingController();
  final ThemeController themeController = Get.put(ThemeController());
  final WifiController wifiController = Get.find(); // Access existing WiFiController

  final RxString selectedRoom = ''.obs; // Make selectedRoom observable

  final List<Map<String, dynamic>> rooms = [
    {'name': 'Living Room', 'icon': Icons.weekend},
    {'name': 'Bedroom', 'icon': Icons.bed},
    {'name': 'Kitchen', 'icon': Icons.dining_sharp},
    {'name': 'Bathroom', 'icon': Icons.bathtub},
    {'name': 'Office', 'icon': Icons.work},
    {'name': 'New Room', 'icon': Icons.add_circle_rounded}, // For adding a new room
  ];

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
                    image: AssetImage(themeController.currentBackgroundImage.value),
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
                          Get.back(); // Go back to the previous screen
                        },
                      ),
                      Text(
                        'Device Setup',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).iconTheme.color,
                            ),
                      ),
                    ],
                  ),
                  AppPadding.paddingH24,
                  Text(
                    'Give your device a name',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                 AppPadding.paddingH24,
                  TextField(
                    controller: deviceNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Device Name',
                    ),
                  ),
                 AppPadding.paddingH24,
                  Text(
                    'Select Room:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  AppPadding.paddingH24,
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Handle room selection
                            selectedRoom.value = rooms[index]['name'];
                            if (selectedRoom.value == 'New Room') {
                              // Clear the new room text field when selecting 'New Room'
                              newRoomController.clear();
                            }
                          },
                          child: Obx(() {
                            // Change color based on selection
                            Color cardColor = selectedRoom.value == rooms[index]['name']
                                ? (Theme.of(context).brightness == Brightness.light
                                    ? AppColors.cardSelectedColorLight
                                    : AppColors.cardSelectedColorDark)
                                : (Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : AppColors.bgSecondayDark);

                            return Card(
                              color: cardColor,
                              elevation: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    rooms[index]['icon'],
                                    size: 30,
                                    color: AppColors.orange,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    rooms[index]['name'],
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ), 
                  Obx(() {
                    // Display New Room text field only when selected
                    if (selectedRoom.value == 'New Room') {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter New Room Name:',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: newRoomController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'New Room Name',
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    } else {
                      return Container(); // Empty container if not selecting a new room
                    }
                  }),AppPadding.paddingH24,AppPadding.paddingH24,AppPadding.paddingH24,
               Align(
                      alignment: Alignment.centerRight,
                      child: 
TextButton.icon(
            onPressed: deviceNameController.text.isNotEmpty &&
                                (selectedRoom.value.isNotEmpty && (selectedRoom.value != 'New Room' || newRoomController.text.isNotEmpty))
                            ? () {
                                // Logic to save the device name and selected room
                                String deviceName = deviceNameController.text;
                                String roomToUse = selectedRoom.value == 'New Room'
                                    ? newRoomController.text
                                    : selectedRoom.value;

                                // Proceed to the next screen or save the info
                                // Get.to(() => NextPage(deviceName: deviceName, room: roomToUse));
                              }
                            : null,
        icon: Icon(
          Icons.arrow_forward,
          color: selectedRoom != null
              ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
              : Colors.grey,
        ),
        iconAlignment: IconAlignment.end,
        label: Text(
          'Next',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: selectedRoom != null
                ? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                : Colors.grey,
          ),
        ),
      )




                    ) 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}