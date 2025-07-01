import 'package:flutter/material.dart';

class AppTheme{

  static const Color _lightCursorColor = Color(0xFF065F46);
  static const Color _lightAccentColor = Color(0xFF065F46);
  static const Color _lightScaffoldColor = Color(0xFFF5F5F7);
  static const Color _lightPrimaryColor = Colors.white;
  static const Color _lightPrimaryVariantColor = Color(0xFF065F46);
  static const Color _lightIconColor = Color(0xff8C8E8D);
  static const Color _lightInBlack = Color(0xff000000);
  static const Color _lightColorSchemePrimary = Color(0xFFe5e5e5);

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightScaffoldColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: _lightCursorColor,
    ),
    primaryColor: _lightPrimaryColor,
    iconTheme: const IconThemeData(
      color: _lightIconColor,
    ),
    fontFamily: 'product-sans',
    textTheme: _lightTextTheme,
    colorScheme: const ColorScheme.light(
      primaryContainer: _lightPrimaryVariantColor,
      primary: _lightColorSchemePrimary,
      secondary: Color(0xffF5F5F5),
      onSecondary: Colors.black,
      tertiary: Colors.black26,
      tertiaryContainer: Color.fromARGB(255, 231, 231, 231),
    ).copyWith(secondary: _lightAccentColor),
  );

  static const TextTheme _lightTextTheme = TextTheme(
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    headlineSmall: TextStyle(
      color: _lightInBlack,
      fontSize: 20,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      color: Color(0xFF737373),
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      color: Color(0xFF065F46),
      fontWeight:FontWeight.w700,
    ),
    bodyLarge: TextStyle(fontSize: 14, color: Color(0xFF737373)),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xFF8F95B2),
      fontSize: 12.0,
    ),
  );
}