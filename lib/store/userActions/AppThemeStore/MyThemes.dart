import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';

class MyThemeProp {
  String name;
  Color color;

  @override
  bool operator ==(other) {
    if (other is! MyThemeProp) {
      return false;
    }
    return name == (other as MyThemeProp).name;
  }

  MyThemeProp({this.name, this.color}) : super();
}

class MyTheme {
  String name;
  MyThemeProp primary;
  MyThemeProp secondary;
  MyThemeProp general;
  MyThemeProp generalSecondary;
  MyThemeProp generalInverted;
  MyThemeProp separators;
  MyThemeProp background;

  MyThemeProp getThemePropByName(String name) {
    if (name == 'primary') {
      return primary;
    } else if (name == 'secondary') {
      return secondary;
    } else if (name == 'general') {
      return general;
    } else if (name == 'generalSecondary') {
      return generalSecondary;
    } else if (name == 'generalInverted') {
      return generalInverted;
    } else if (name == 'separators') {
      return separators;
    } else if (name == 'background') {
      return background;
    }

    return primary;
  }

  MyTheme(
      {this.name,
      this.primary,
      this.secondary,
      this.general,
      this.generalSecondary,
      this.generalInverted,
      this.separators,
      this.background})
      : super();
}

class MyThemes {
  static MyTheme lightBlue = MyTheme(
      name: 'Light Blue',
      primary: MyThemeProp(name: 'primary', color: Color(0xFF007aff)),
      secondary: MyThemeProp(name: 'secondary', color: Color(0xFFd2e7ff)),
      general: MyThemeProp(name: 'general', color: Color(0xFF111111)),
      generalSecondary:
          MyThemeProp(name: 'generalSecondary', color: Color(0xFFbdbdbf)),
      generalInverted:
          MyThemeProp(name: 'generalInverted', color: Color(0xFFf9f9f9)),
      separators: MyThemeProp(name: 'separators', color: Color(0xFFC2C2C6)),
      background: MyThemeProp(name: 'background', color: Color(0xFFffffff)));

  static MyTheme darkBlue = MyTheme(
      name: 'Dark Blue',
      primary: MyThemeProp(name: 'primary', color: MyColors.black),
      secondary: MyThemeProp(name: 'secondary', color: MyColors.black),
      general: MyThemeProp(name: 'general', color: MyColors.black),
      generalSecondary:
          MyThemeProp(name: 'generalSecondary', color: MyColors.black),
      generalInverted:
          MyThemeProp(name: 'generalInverted', color: MyColors.iconDarkGray),
      separators: MyThemeProp(name: 'separators', color: MyColors.black),
      background: MyThemeProp(name: 'background', color: MyColors.black));
}
