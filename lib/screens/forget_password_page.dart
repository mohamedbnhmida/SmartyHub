import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarty_hub/utils/app_helpers.dart';
  
import '../controllers/forget_password_controller.dart';
import '../controllers/theme_controller.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_padding.dart';
import '../utils/app_routes.dart';
import '../utils/app_strings.dart';
import '../widgets/app_logo.dart';
import '../widgets/loading_progress.dart';
import '../widgets/theme_icon_tile.dart'; 
class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  final ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());
  final ThemeController themecontroller = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
                Obx(() => Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage(
                          themecontroller.currentBackgroundImage.value),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
                SafeArea(
        child: 
            Center(
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: 296,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppLogo(),
                        AppPadding.paddingH24,
                        Text(
                          AppStrings.forgetPasswordTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headlineMedium!
                                      .color),
                        ),
                        AppPadding.paddingH24,
                        Text(
                              AppStrings.rememberedPassword,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                            AppPadding.paddingH24,
                        Obx(() => TextFormField(
                              controller: forgetPasswordController.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: SvgPicture.asset(
                                  AppAssets.mailIcon,
                                  height: 16,
                                  width: 20,
                                  fit: BoxFit.none,
                                ),
                                suffixIcon: SvgPicture.asset(
                                  forgetPasswordController.isEmailValid.value
                                      ? AppAssets.checkIcon
                                      : AppAssets.closeIcon,
                                  width: 17,
                                  height: 11,
                                  fit: BoxFit.none,
                                  colorFilter: ColorFilter.mode(
                                    forgetPasswordController.isEmailValid.value
                                        ? Colors.green
                                        : Colors.red,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                hintText: AppStrings.emailHint,
                              ),
                              onChanged: forgetPasswordController.validateEmail,
                            )),
                        AppPadding.paddingH16,
                        Obx(() {
                          if (forgetPasswordController.isLoading.value) {
                            return LoadingProgress();
                          } else {
                            return SizedBox(
                              width: 296,
                              child: ElevatedButton(
                                onPressed: () {showSnackbar("Error", "message", SnackbarType.error);},
                                child:   Text(AppStrings.resetPasswordButton),
                              ),
                            );
                          }
                        }),
                        AppPadding.paddingH24,
                       
                      ],
                    ),
                  ),
                ),
              ),
                 ) ),
         
            Positioned(
              top: 50,
              left: 20,
              child:   IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
            ),
          ],
        ),
         
    );
  }
}