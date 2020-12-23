import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/entities/skeleton_screen.dart';

import 'bottom_navbar.dart';

class ScalingScreenScaffold extends StatelessWidget {
  final SkeletonScreen screen;

  ScalingScreenScaffold({
    Key key,
    this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: AspectRatio(
                aspectRatio: screen.showNavBar
                    ? screen.size.bodyAspectRatio
                    : screen.size.boxAspectRatio,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                    width: screen.size.boxWidth,
                    height: screen.showNavBar
                        ? screen.size.bodyHeight
                        : screen.size.boxHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: screen.widgets ?? [],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (screen.showNavBar)
            BottomNavBar(
              width: screen.size.navBarWidth,
              height: screen.size.navBarHeight,
              navBarData: screen.navBar,
            ),
        ],
      ),
    );
  }
}
