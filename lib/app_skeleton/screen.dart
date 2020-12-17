import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/screen_load_from_json.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class Screen extends StatelessWidget {
  final List<WidgetDecorator> widgets;
  final RandomKey id;
  final AppBuildyBottomNavBar bottomNavigation;
  bool get navBarShown => bottomNavigation != null;

  Screen({
    Key key,
    this.widgets,
    this.id,
    this.bottomNavigation,
  }) : super(key: key);

  factory Screen.fromJson(Map<String, dynamic> jsonScreen,
      {AppBuildyBottomNavBar botNavBar}) {
    return ScreenLoadFromJson(jsonScreen).load(botNavBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: AspectRatio(
                aspectRatio: navBarShown
                    ? abPreviewConst.bodyAspectRatio
                    : abPreviewConst.phoneBoxAspectRatio,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                    width: abPreviewConst.phoneBoxWidth,
                    height: navBarShown
                        ? abPreviewConst.bodyHeight
                        : abPreviewConst.phoneBoxHeight,
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
