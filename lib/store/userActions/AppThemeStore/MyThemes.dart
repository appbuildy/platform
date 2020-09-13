import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';

class MyTheme {
  String name;
  Color primary;
  Color secondary;
  Color body;
  Color bodySecondary;
  Color background;

  MyTheme(
      {this.name,
      this.primary,
      this.secondary,
      this.body,
      this.bodySecondary,
      this.background})
      : super();
}

class MyThemes {
  static MyTheme lightBlue = MyTheme(
      name: 'Light Blue',
      primary: MyColors.mainBlue,
      secondary: MyColors.white,
      body: MyColors.gray,
      bodySecondary: MyColors.iconDarkGray,
      background: MyColors.black);

  static MyTheme darkBlue = MyTheme(
      name: 'Dark blue',
      primary: MyColors.mainBlue,
      secondary: MyColors.black,
      body: MyColors.white,
      bodySecondary: MyColors.iconDarkGray,
      background: MyColors.white);
}
