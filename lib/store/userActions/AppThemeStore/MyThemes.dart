import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';

class MyThemeProp {
  String name;
  Color color;

  @override
  bool operator ==(other) {
    // Dart ensures that operator== isn't called with null
    // if(other == null) {
    //   return false;
    // }
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
  MyThemeProp body;
  MyThemeProp bodySecondary;
  MyThemeProp background;

  MyThemeProp getThemePropByName(String name) {
    if (name == 'primary') {
      return primary;
    } else if (name == 'secondary') {
      return secondary;
    } else if (name == 'body') {
      return body;
    } else if (name == 'bodySecondary') {
      return bodySecondary;
    } else if (name == 'background') {
      return background;
    }

    return primary;
  }

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
      primary: MyThemeProp(name: 'primary', color: MyColors.mainBlue),
      secondary: MyThemeProp(name: 'secondary', color: MyColors.white),
      body: MyThemeProp(name: 'body', color: MyColors.gray),
      bodySecondary:
          MyThemeProp(name: 'bodySecondary', color: MyColors.iconDarkGray),
      background: MyThemeProp(name: 'background', color: MyColors.black));

  static MyTheme darkBlue = MyTheme(
      name: 'Dark blue',
      primary: MyThemeProp(name: 'primary', color: MyColors.black),
      secondary: MyThemeProp(name: 'secondary', color: MyColors.black),
      body: MyThemeProp(name: 'body', color: MyColors.gray),
      bodySecondary:
          MyThemeProp(name: 'bodySecondary', color: MyColors.iconDarkGray),
      background: MyThemeProp(name: 'background', color: MyColors.black));
}
