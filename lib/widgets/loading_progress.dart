import 'package:flutter/material.dart';
import 'package:smarty_hub/utils/app_assets.dart'; 

import '../utils/app_constants.dart';

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.loading,
      width: 70, // Set width and height as needed
      height: 70,
    );
  }
}
