import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme=ThemeData(

    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 10.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue[800],
      elevation: 20.0,
    ),
    textTheme: TextTheme(

      bodyText1: TextStyle(
          // fontFamily: 'Play',
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
          color: Colors.black),
      subtitle1: TextStyle(
          // fontFamily: 'Play',

          fontSize: 23.0,
          height: 1.0,
          color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
    ));