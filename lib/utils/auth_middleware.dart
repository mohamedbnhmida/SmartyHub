import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
import 'app_routes.dart';
import 'app_variables.dart'; 

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Check if the user is logged in
    if (!AppVariables.isLoggedIn) {
      // If not logged in, redirect to the login page
      return const RouteSettings(name: AppRoutes.login);
    }
    // If logged in, proceed to the requested route
    return null;
  }
}