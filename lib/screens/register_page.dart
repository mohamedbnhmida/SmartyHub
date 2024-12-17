import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; 
 
import '../controllers/register_controller.dart';
import '../controllers/theme_controller.dart';
import '../utils/app_assets.dart';
import '../utils/app_padding.dart';
import '../utils/app_routes.dart';
import '../utils/app_strings.dart';
import '../widgets/app_logo.dart';
import '../widgets/background_time_tile.dart';
import '../widgets/loading_progress.dart';
import '../widgets/theme_icon_tile.dart';
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final RegisterController registerController = Get.put(RegisterController());
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
                          AppStrings.registerTitle,
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
                              AppStrings.signUpDescription,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                        AppPadding.paddingH24,
                        Obx(() => TextFormField(
                              controller: registerController.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: SvgPicture.asset(
                                  AppAssets.mailIcon,
                                  height: 16,
                                  width: 20,
                                  fit: BoxFit.none,
                                ),
                                suffixIcon: SvgPicture.asset(
                                  registerController.isEmailValid.value
                                      ? AppAssets.checkIcon
                                      : AppAssets.closeIcon,
                                  width: 17,
                                  height: 11,
                                  fit: BoxFit.none,
                                  colorFilter: ColorFilter.mode(
                                    registerController.isEmailValid.value
                                        ? Colors.green
                                        : Colors.red,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                hintText: AppStrings.emailHint,
                              ),
                              onChanged: registerController.validateEmail,
                            )),
                        AppPadding.paddingH16,
                        TextFormField(
                          controller: registerController.nameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: AppStrings.nameHint,
                          ),
                        ),
                        AppPadding.paddingH16,
                        Obx(() {
                          return TextFormField(
                            controller: registerController.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: registerController.obscurePassword.value,
                            decoration: InputDecoration(
                              prefixIcon: SvgPicture.asset(
                                AppAssets.lockIcon,
                                height: 16,
                                width: 20,
                                fit: BoxFit.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  registerController.obscurePassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  registerController.obscurePassword.value =
                                      !registerController.obscurePassword.value;
                                },
                              ),
                              hintText: AppStrings.passwordHint,
                            ),
                          );
                        }),
                        AppPadding.paddingH16,
                        Obx(() {
                          return TextFormField(
                            controller: registerController.confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: registerController.obscureConfirmPassword.value,
                            decoration: InputDecoration(
                              prefixIcon: SvgPicture.asset(
                                AppAssets.lockIcon,
                                height: 16,
                                width: 20,
                                fit: BoxFit.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  registerController.obscureConfirmPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  registerController.obscureConfirmPassword.value =
                                      !registerController.obscureConfirmPassword.value;
                                },
                              ),
                              hintText: AppStrings.confirmPasswordHint,
                            ),
                          );
                        }),
                        AppPadding.paddingH16,
                        Obx(() {
                          if (registerController.isLoading.value) {
                            return LoadingProgress();
                          } else {
                            return SizedBox(
                              width: 296,
                              child: ElevatedButton(
                                onPressed: () {Get.toNamed(AppRoutes.deviceBluetoothSetup);},
                                child: const Text(AppStrings.registerButton),
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
                              AppStrings.alreadyMember,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed(AppRoutes.login),
                              child: const Text(AppStrings.signIn),
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
  