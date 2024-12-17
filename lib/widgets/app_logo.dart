
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_assets.dart';
import '../utils/app_constants.dart'; 
 
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
        radius: 30, // Adjust radius to fit the image
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            AppAssets.logo, // Replace with your image path
            height: 40,
            width: 40,
          ),
        ),
      ),
    ),
        SizedBox(width: 16),
Text(
      'Smarty Hub',
      style: GoogleFonts.lalezar(
        textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryTextTheme.headlineLarge!.color,
              
            ),
      ),
    )
      ],
    );
  }
}
