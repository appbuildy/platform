import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/screen_load_from_json.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/utils/RandomKey.dart';

const double screenHeight = 812;
const double kNavbarHeight = 82;

class Screen extends StatelessWidget {
  final List<WidgetDecorator> widgets;
  final RandomKey id;
  final BottomNavigation bottomNavigation;

  Screen({Key key, this.widgets, this.id, this.bottomNavigation})
      : super(key: key);

  factory Screen.fromJson(Map<String, dynamic> jsonScreen,
      {BottomNavigation botNavBar}) {
    return ScreenLoadFromJson(jsonScreen).load(botNavBar);
  }

  @override
  Widget build(BuildContext context) {
    final double height =
        screenHeight - (bottomNavigation != null ? kNavbarHeight : 0);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: AspectRatio(
                aspectRatio: 350 / height,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                    width: 350,
                    height: height,
                    child: Stack(
                      children: widgets ?? [],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (bottomNavigation != null) bottomNavigation,
        ],
      ),
    );
  }
}
