import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarty_hub/utils/app_colors.dart';
import 'package:smarty_hub/utils/app_constants.dart'; 

class AppTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.bgLight,

      appBarTheme: AppBarTheme(backgroundColor: AppColors.bgSecondayLight),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.bgSecondayLight,
        surfaceTintColor: AppColors.bgSecondayLight,
      ),
      primaryColor: AppColors.primary,
       cardColor: AppColors.bgSecondayLight,
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          .apply(
              bodyColor: AppColors.titleLight,
              displayColor: AppColors.titleLight)
          .copyWith(
            bodyLarge: const TextStyle(color: AppColors.textLight),
            bodyMedium: const TextStyle(color: AppColors.textLight),
            bodySmall: const TextStyle(color: AppColors.textLight),
          ),
      iconTheme: const IconThemeData(color: AppColors.iconGrey),
      dividerColor: AppColors.highlightLight,
      dividerTheme: const DividerThemeData(
        thickness: 1,
        color: AppColors.highlightLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 56),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.orange,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppConstants.borderRadius),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.orange,
          minimumSize: const Size(100, 56),
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.padding, vertical: AppConstants.padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          side: BorderSide(color: AppColors.highlightLight, width: 2),
        ),
      ),
          textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.orange,
           textStyle: const TextStyle(
      color: AppColors.orange, // Set the text color here
    ),
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
      ),
      inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
      expansionTileTheme:
          const ExpansionTileThemeData(shape: const RoundedRectangleBorder()),
      badgeTheme:
          BadgeThemeData(backgroundColor: AppColors.error, smallSize: 8),

          popupMenuTheme: PopupMenuThemeData(
        color: AppColors.bgSecondayLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(color: AppColors.textLight),
      ),primaryTextTheme: TextTheme(headlineLarge: TextStyle(color: AppColors.primary),headlineMedium:TextStyle(color: AppColors.secondaryTextLight) )
  , textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.cursorColor,selectionColor: AppColors.selectionColor,selectionHandleColor: AppColors.cursorColor)
  , 
       colorScheme: ColorScheme.light(
        primary: AppColors.primary, // Header background color
        onPrimary: AppColors.textLight, // Header text color
        surface:   AppColors.bgLight, // DatePicker background color
        onSurface: AppColors.textLight, // Body text color
      ),
    );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.bgDark,
      appBarTheme: AppBarTheme(color: AppColors.bgSecondayDark),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.bgSecondayDark,
        surfaceTintColor: AppColors.bgSecondayDark,
      ),
      primaryColor: AppColors.primary,
       cardColor: AppColors.bgSecondayDark,
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          .apply(
              bodyColor: AppColors.titleDark,
              displayColor: AppColors.titleDark)
          .copyWith(
            bodyLarge: const TextStyle(color: AppColors.textDark),
            bodyMedium: const TextStyle(color: AppColors.textDark),
            bodySmall: const TextStyle(color: AppColors.textDark),
          ),
      iconTheme: const IconThemeData(color: AppColors.iconDark),
      dividerColor: AppColors.highlightDark,
      dividerTheme: const DividerThemeData(
        thickness: 1,
        color: AppColors.highlightDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 56),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.orange,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppConstants.borderRadius),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.titleDark,
          minimumSize: const Size(100, 56),
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.padding, vertical: AppConstants.padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          side: BorderSide(color: AppColors.highlightDark, width: 2),
        ),
      ),
          textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.orange,  textStyle: const TextStyle(
      color: AppColors.orange, // Set the text color here
    ),
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding, vertical: AppConstants.padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
      ),
      inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
      expansionTileTheme:
          const ExpansionTileThemeData(shape: const RoundedRectangleBorder()),
      badgeTheme:
          BadgeThemeData(backgroundColor: AppColors.error, smallSize: 8),
          popupMenuTheme: PopupMenuThemeData(
        color: AppColors.bgSecondayDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(color: AppColors.textDark),
      ),primaryTextTheme: TextTheme(headlineLarge: TextStyle(color: AppColors.primaryTextDark),headlineMedium:TextStyle(color: AppColors.secondaryTextDark) )
      , textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.cursorColor,selectionColor: AppColors.selectionColor,selectionHandleColor: AppColors.cursorColor)
 ,colorScheme: ColorScheme.dark(
        primary: AppColors.primary, // Header background color
        onPrimary: AppColors.textDark, // Header text color
        surface: AppColors.bgSecondayDark, // DatePicker background color
        onSurface: AppColors.textDark, // Body text color
      ) 
     );
  }
}
class AppTextFormFieldTheme {
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.textLight,
    suffixIconColor: AppColors.textLight,
    fillColor: AppColors.bgSecondayLight,
    filled: true,
    labelStyle: const TextStyle().copyWith(color: AppColors.titleLight),
    hintStyle: const TextStyle(
      fontSize: 14.0,
    ).copyWith(color: AppColors.textGrey),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppConstants.inputFieldRadius),
      borderSide: BorderSide.none,
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppConstants.inputFieldRadius),
      borderSide: BorderSide.none, // No border
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppConstants.inputFieldRadius),
      borderSide: BorderSide.none, // No border
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppConstants.inputFieldRadius),
      borderSide: BorderSide.none, // No border
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppConstants.inputFieldRadius),
      borderSide: BorderSide.none, // No border
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.textLight,
    suffixIconColor: AppColors.textLight,
    fillColor: AppColors.bgSecondayDark,
    filled: true,
    labelStyle: const TextStyle().copyWith(color: AppColors.titleLight),
    hintStyle: const TextStyle().copyWith(color: AppColors.textGrey),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppConstants.inputFieldRadius),
      borderSide: BorderSide.none, // No border
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppConstants.inputFieldRadius),
      borderSide: BorderSide.none, // No border
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppConstants.inputFieldRadius),
      borderSide: BorderSide.none, // No border
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppConstants.inputFieldRadius),
      borderSide: BorderSide.none, // No border
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppConstants.inputFieldRadius),
      borderSide: BorderSide.none, // No border
    ),
    
  );
}