import 'package:dots_indicator/dots_indicator.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';

final ValueNotifier<ThemeData> currentThemeNotifier = ValueNotifier(lightMode);

ThemeData get lightMode => ThemeData(

  colorScheme: const ColorScheme.light(
    primary: AppConstants.eslGreen,
    secondary: AppConstants.eslYellow,
    onSecondary: AppConstants.eslGrey,
    inversePrimary: AppConstants.eslGrey,
  ),

  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0,
    shadowColor: AppConstants.eslGrey,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(color: AppConstants.eslGrey, fontSize: 16),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppConstants.eslWhite,
    foregroundColor: AppConstants.eslGreen,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: AppConstants.eslWhite,
    showUnselectedLabels: true,
    selectedItemColor: AppConstants.eslGreen,
    unselectedItemColor: AppConstants.eslGrey,
    selectedLabelStyle: boldTextStyle.copyWith(color: AppConstants.eslGreen),
    unselectedLabelStyle: boldTextStyle.copyWith(color: AppConstants.eslGreen),
  ),

  cardTheme: const CardThemeData(
    shadowColor: AppConstants.eslGrey,
    elevation: 3,
    shape: RoundedRectangleBorder(),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppConstants.eslGrey),
      borderRadius: BorderRadius.zero,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppConstants.eslGreyTint),
      borderRadius: BorderRadius.zero,
    ),

    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppConstants.eslGrey),
      borderRadius: BorderRadius.zero,
    ),
    floatingLabelStyle: TextStyle(color: AppConstants.eslGrey),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppConstants.eslYellow,
    selectionColor: AppConstants.eslGreenTint,
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStatePropertyAll(0),
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      ),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
      foregroundColor: WidgetStatePropertyAll(Colors.black),
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      backgroundColor: WidgetStatePropertyAll(AppConstants.eslYellow),
    ),
  ),
  scaffoldBackgroundColor: AppConstants.eslWhite,
  dividerColor: Colors.transparent,
);

const TextStyle authWhiteTextStyle = TextStyle(
  color: AppConstants.eslWhite,
  fontSize: 16,
);

const TextStyle authGreyTextStyle = TextStyle(
  color: AppConstants.eslGrey,
  fontSize: 16,
);

const TextStyle authWelcome34TextStyle = TextStyle(
  color: AppConstants.eslGrey,
  fontWeight: FontWeight.bold,
  fontSize: 34,
);

const underlinedTextStyle = TextStyle(
  decoration: TextDecoration.underline,
  fontWeight: FontWeight.bold,
  color: AppConstants.eslGreen,
);

const TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.bold);

DotsDecorator dotsDecorator = DotsDecorator(
  size: const Size.square(12.0),
  activeSize: const Size(30.0, 9.0),
  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
);

ThemeData get darkMode => ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: AppConstants.eslGreen,
    secondary: AppConstants.eslYellow,
    onSecondary: AppConstants.eslGrey,
    inversePrimary: AppConstants.eslGrey,
  ),
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0,
    color: AppConstants.eslGrey,
    shadowColor: AppConstants.eslGreyTint,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(color: AppConstants.eslGreyText, fontSize: 16),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppConstants.eslWhite,
    foregroundColor: AppConstants.eslGreen,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: AppConstants.eslGrey,
    selectedItemColor: AppConstants.eslGreen,
    showUnselectedLabels: true,
    unselectedItemColor: AppConstants.eslWhite,
    selectedLabelStyle: boldTextStyle.copyWith(color: AppConstants.eslGreen),
    unselectedLabelStyle: boldTextStyle.copyWith(color: AppConstants.eslWhite),
  ),
  cardTheme: const CardThemeData(
    shadowColor: AppConstants.eslGreyTint,
    elevation: 3,
    shape: RoundedRectangleBorder(),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppConstants.eslWhite),
      borderRadius: BorderRadius.zero,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppConstants.eslGreyTint),
      borderRadius: BorderRadius.zero,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppConstants.eslWhite),
      borderRadius: BorderRadius.zero,
    ),
    floatingLabelStyle: TextStyle(color: AppConstants.eslWhite),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppConstants.eslYellow,
    selectionColor: AppConstants.eslGreenTint,
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      ),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
      foregroundColor: WidgetStatePropertyAll(AppConstants.eslWhite),
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      backgroundColor: WidgetStatePropertyAll(AppConstants.eslYellow),
    ),
  ),
  scaffoldBackgroundColor: AppConstants.eslGrey,
  dividerColor: Colors.transparent,
);

ThemeData currentTheme = lightMode;
