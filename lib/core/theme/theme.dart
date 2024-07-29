import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(20));
  static final lightThemeMode = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    primaryColor: AppPalette.primaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppPalette.backgroundColor,
        backgroundColor: AppPalette.primaryColor,
        minimumSize: const Size(220, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              20.0), // Adjust the value to match the rounded corners
        ),
        elevation: 10,
        textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: 'Britanica Semi Expanded Black',
        ),
      ),
      // style: ButtonStyle(
      //   backgroundColor: WidgetStateProperty.all<Color>(
      //       AppPalette.primaryColor),
      //   shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      //     RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(
      //           20.0), // Adjust the value to match the rounded corners
      //     ),
      //   ),
      //   minimumSize: WidgetStateProperty.all(Size(232.32, 72.07)),
      //   textStyle: WidgetStateProperty.all<TextStyle>(
      //     const TextStyle(
      //       fontSize: 20.0,
      //       fontFamily: 'Britanica Semi Expanded Black',
      //     ),
      //   ),
      //   // padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      //   //   const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      //   // ),
      // ),
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
          color: AppPalette.textColor,
          fontFamily: 'Britanica',
          fontSize: 20
      ),
      titleLarge:
          TextStyle(
              color: AppPalette.textColor,
              fontFamily: '$font Expanded Heavy',
            fontSize: 20
          ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
            color: Color(0x59171a1e), fontFamily: 'Britanica Expanded Black'),
        contentPadding: const EdgeInsets.all(18),
        enabledBorder: _border(Colors.white),
        focusedBorder: _border(),
        constraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20
        )),
  );
}
