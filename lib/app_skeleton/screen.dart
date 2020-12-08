import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/screen_load_from_json.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class Screen extends StatelessWidget {
  final RandomKey id;
  final BottomNavigation bottomNavigation;
  final List<WidgetDecorator> widgets;

  Screen({Key key, this.widgets, this.id, this.bottomNavigation})
      : super(key: key);

  factory Screen.fromJson(Map<String, dynamic> jsonScreen,
      {BottomNavigation bottomNavigation}) {
    return ScreenLoadFromJson(jsonScreen).load(bottomNavigation);
  }

  @override
  Widget build(BuildContext context) {
    var nav = bottomNavigation ?? Container();

    return Scaffold(
        body: Stack(
      children: [
        ...widgets,
        // if (bottomNavigation != null) bottomNavigation,
        nav,
      ],
    ));
  }
}
