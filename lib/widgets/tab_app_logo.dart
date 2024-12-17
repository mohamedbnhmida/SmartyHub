
import 'package:flutter/material.dart'; 

import '../utils/app_assets.dart';
import '../utils/app_constants.dart';

class TabAppLogo extends StatelessWidget {
  const TabAppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.padding,
          vertical: AppConstants.padding * 1.5),
      child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 25, // Adjust radius to fit the image
        child: Image.asset(
          AppAssets.logo, // Replace with your image path
          height: 30,
          width: 30 ,
        ),
      ),
    ),
    );
  }
}
