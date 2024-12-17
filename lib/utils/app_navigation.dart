import 'package:get/get.dart';
import 'package:smarty_hub/screens/bluetooth_device_setup_screen.dart';
import 'package:smarty_hub/screens/forget_password_page.dart';
import 'package:smarty_hub/screens/home_screen.dart';
import 'package:smarty_hub/screens/login_page.dart';
import 'package:smarty_hub/screens/wifi_device_setup_screen.dart';
 
import '../screens/register_page.dart';
import 'app_routes.dart';
import 'auth_middleware.dart'; 
class AppNavigation {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      middlewares: [AuthMiddleware()], // Add middleware here
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(),
    ), 
      GetPage(
      name: AppRoutes.forgetPassword,
      page: () => ForgetPasswordPage(),
    ), 
      GetPage(
      name: AppRoutes.forgetPassword,
      page: () => ForgetPasswordPage(),
    ), 
      GetPage(
      name: AppRoutes.deviceBluetoothSetup,
      page: () => BluetoothPage(),
    ), 
     
  ];
}