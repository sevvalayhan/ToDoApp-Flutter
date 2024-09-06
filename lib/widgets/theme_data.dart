import 'package:flutter/material.dart';
import 'package:todo_app_comp/constants/colors.dart';

final ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(backgroundColor: myLila),
);
final ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(backgroundColor: Colors.pink),
  scaffoldBackgroundColor: Colors.grey[900],
 primaryColor: Colors.white,
  brightness: Brightness.dark,
);
