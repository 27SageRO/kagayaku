import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

final appThemeData = {
  AppTheme.Dark: CupertinoThemeData(
    brightness: Brightness.dark,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(),
    ),
  ),
  AppTheme.Light: CupertinoThemeData(
    brightness: Brightness.light,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(color: Colors.black87),
    ),
  ),
};
