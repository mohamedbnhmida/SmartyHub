import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarty_hub/screens/test.dart';

import '../controllers/login_controller.dart';
import '../controllers/theme_controller.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_padding.dart';
import '../utils/app_routes.dart';
import '../utils/app_strings.dart';
import '../widgets/app_logo.dart';
import '../widgets/background_time_tile.dart';
import '../widgets/loading_progress.dart';
import '../widgets/theme_icon_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController controller = Get.put(LoginController());
  final ThemeController themecontroller = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:  Stack(
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
        child: Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: 296,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppLogo(),
                        AppPadding.paddingH24,
                        Text(
                          AppStrings.signIn,
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
                              AppStrings.signInDescription,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                        AppPadding.paddingH24,
                        Obx(() => TextFormField(
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: SvgPicture.asset(
                                  AppAssets.mailIcon,
                                  height: 16,
                                  width: 20,
                                  fit: BoxFit.none,
                                ),
                                suffixIcon: SvgPicture.asset(
                                  controller.isEmailValid.value
                                      ? AppAssets.checkIcon
                                      : AppAssets.closeIcon,
                                  width: 17,
                                  height: 11,
                                  fit: BoxFit.none,
                                  colorFilter: ColorFilter.mode(
                                    controller.isEmailValid.value
                                        ? Colors.green
                                        : Colors.red,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                hintText: AppStrings.emailHint,
                              ),
                              onChanged: controller.validateEmail,
                            )),
                        AppPadding.paddingH16,
                        Obx(() => TextFormField(
                              controller: controller.passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: controller.obscurePassword.value,
                              decoration: InputDecoration(
                                prefixIcon: SvgPicture.asset(
                                  AppAssets.lockIcon,
                                  height: 16,
                                  width: 20,
                                  fit: BoxFit.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.obscurePassword.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    controller.obscurePassword.value =
                                        !controller.obscurePassword.value;
                                  },
                                ),
                                hintText: AppStrings.passwordHint,
                              ),
                            )),
                        AppPadding.paddingH16,
                        TextButton(
                          onPressed: () =>
                              Get.toNamed(AppRoutes.forgetPassword),
                          child: const Text(AppStrings.forgotPassword),
                        ),
                        AppPadding.paddingH16,
                        Obx(() {
                          if (controller.isLoading.value) {
                            return LoadingProgress();
                          } else {
                            return Container(
                              width: 296,
                              child: ElevatedButton(
                                onPressed: () { 
                                },
                                child: const Text(AppStrings.signInButton),
                              ),
                            );
                          }
                        }),
                        AppPadding.paddingH24,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.noAccount,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textGrey),
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed(AppRoutes.register),
                              child: const Text(AppStrings.register),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
 
           
              Positioned(
                top: 10,
                right: 20,
                child:  SafeArea( child:Row(
                  children: [
                    BackgroundThemeTile(),
                    AppPadding.paddingW8,
                    ThemeIconTile(
                      isDark: themecontroller.isDarkTheme.value,
                      onPressed: () {
                        themecontroller
                            .toggleTheme(!themecontroller.isDarkTheme.value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
         
      ),
    );
  }
 }
