import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetupThemes {
  static TextTheme textLightTheme = const TextTheme(
    bodyText1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: 'Roboto'),
    headline1: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Roboto'),
    headline2: TextStyle(
        fontSize: 21.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: 'Roboto'),
    headline3: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
        fontFamily: 'Roboto'),
    headline6: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: 'Roboto'),
  );
  static TextTheme textDarkTheme = const TextTheme(
    bodyText1: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.white),
    headline1: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline2: TextStyle(
        fontSize: 21.0, fontWeight: FontWeight.w700, color: Colors.white),
    headline3: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
    headline6: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
  );

  static ThemeData lightTheme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black87,
            ),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white),
        brightness: Brightness.light,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white, elevation: 32.0),
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        textTheme: textLightTheme);
  }

  static ThemeData darkTheme() {
    return ThemeData(
        primaryColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black87,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: Colors.black,
            elevation: 0.0),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        textTheme: textDarkTheme);
  }
}
