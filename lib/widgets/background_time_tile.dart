import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import 'loading_progress.dart';
class BackgroundThemeTile extends StatelessWidget {
  BackgroundThemeTile({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());

  void _showBackgroundPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Choose Background')),
          ),
          content: Container(
            height: 400,
            width: 400,
            child: FutureBuilder<void>(
              future: _preloadImages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: LoadingProgress());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading images'));
                } else {
                  return ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      scrollbars: true,
                    ),
                    child: Center(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          String bgPath = 'assets/backgrounds/bg$index.png';
                          bool isSelected =
                              themeController.currentBackgroundImage.value ==
                                  bgPath;

                          return GestureDetector(
                            onTap: () {
                              themeController.setBackgroundImage(bgPath);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.orange
                                        : Colors.transparent,
                                    width: isSelected ? 3 : 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    bgPath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _preloadImages() async {
    for (int i = 0; i < 12; i++) {
      String bgPath = 'assets/backgrounds/bg$i.png';
      await precacheImage(AssetImage(bgPath), Get.context!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.highlightLight.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(AppConstants.padding * 0.25),
        child: InkWell(
          onTap: () => _showBackgroundPicker(context),
          child: Container(
            decoration: BoxDecoration(
              color: themeController.isDarkTheme.value
                  ? AppColors.bgSecondayDark
                  : AppColors.bgSecondayLight,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.color_lens,
                size: 24,
                color: themeController.isDarkTheme.value
                    ? AppColors.bgSecondayLight
                    : AppColors.bgSecondayDark,
              ),
            ),
          ),
        ),
      );
    });
  }
}