import 'package:flutter/material.dart';

var lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.deepPurple.shade100,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple.shade400,
      titleTextStyle:const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(10),
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 4,
          )
        ),
        ),
);


var darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.deepPurple.shade100,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple.shade400,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(10),
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(),
        ),
);
