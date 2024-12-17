import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/preferences_service.dart';
import 'utils/app_routes.dart';
import 'controllers/theme_controller.dart';
import 'utils/app_navigation.dart';
import 'utils/app_theme.dart';
import 'utils/app_variables.dart';


void main() async { 
  await setupApp(); 
  runApp(  MyApp());     
}


Future<void> setupApp() async { 
  WidgetsFlutterBinding
      .ensureInitialized();   
  final PreferencesService preferencesService = Get.put(PreferencesService()); 
  AppVariables.authToken = await preferencesService.getAuthToken() ?? '';
  AppVariables.isLoggedIn = await preferencesService.getIsLoggedIn() ?? false;  
  Get.put(ThemeController());
}

class MyApp extends StatelessWidget { 
    MyApp({super.key});
  final ThemeController controller = Get.find<ThemeController>(); 

  @override
  Widget build(BuildContext context) {
  return Obx(() => GetMaterialApp(
          themeMode: controller.theme,
          theme: AppTheme.light(context),
          darkTheme: AppTheme.dark(context),
          debugShowCheckedModeBanner: false,
          initialRoute: AppVariables.isLoggedIn ? AppRoutes.home : AppRoutes.login,
          getPages: AppNavigation.routes,
        ));
}
}
