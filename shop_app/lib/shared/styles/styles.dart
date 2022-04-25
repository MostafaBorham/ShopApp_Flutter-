import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

final ThemeData appLightTheme = ThemeData(
  primarySwatch: appColor,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    color: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 60,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.blueGrey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white),
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
  ),
  fontFamily: 'Chrusty',
);
final ThemeData appDarkTheme = ThemeData(
  primarySwatch: appColor,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    color: Colors.black,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  scaffoldBackgroundColor: Colors.black,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 60,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black),
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: Colors.white,
    labelStyle: const TextStyle(color: Colors.white),
    border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(10)),
  ),
);
