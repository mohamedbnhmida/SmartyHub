import 'package:flutter/material.dart';

import 'app_colors.dart'; 
class AppConstants { 
 

  static const double padding = 16.0;
  static const double borderRadius = 25.0;
  static const double inputFieldRadius = 25.0;
  static const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppConstants.borderRadius),
      ),
      borderSide: BorderSide.none);
  static OutlineInputBorder focusedOutlineInputBorder =
      outlineInputBorder.copyWith(
          borderSide: const BorderSide(width: 2, color: AppColors.primary));
  static const int connectionTimeout = 30000; // 30 secondes pour la connexion
  static const int receiveTimeout = 60000; // 60 secondes pour la réception
}
