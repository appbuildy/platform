import 'package:flutter/material.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';

import 'fullscreen_app.dart';

class PhoneScreen extends StatelessWidget {
  final Size targetScreenSize;
  final Size screenSizeInConstructor;
  final double navHeight;
  final Widget nav;
  final List<WidgetDecorator> widgets;

  PhoneScreen({
    @required this.targetScreenSize,
    @required this.screenSizeInConstructor,
    @required this.navHeight,
    @required this.nav,
    @required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    double targetHeight = targetScreenSize.height < screenSizeInConstructor.height ? targetScreenSize.height : screenSizeInConstructor.height;

    double phoneFrameThickness = 2;

    return Stack(
      children: [
        Container(
          width: screenSizeInConstructor.width + phoneFrameThickness * 2,
          height: targetHeight + phoneFrameThickness * 2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40.0),
            border: Border.all(
              width: phoneFrameThickness,
              color: Colors.black,
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 2),
                color: Colors.black.withOpacity(0.15),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(39.0),
            child: Fullscreen(
              targetScreenSize: Size(screenSizeInConstructor.width, targetHeight),
              screenSizeInConstructor: this.screenSizeInConstructor,
              navHeight: this.navHeight,
              nav: this.nav,
              widgets: this.widgets,
            ),
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            child: Image.network(
                'assets/icons/meta/status-bar.svg'),
        ),
        Positioned(
          bottom: 7,
          right: 0,
          left: 0,
          child: Container(
            child: Center(
              child: Container(
                width: 134,
                height: 5,
                decoration: BoxDecoration(
                  color: Color(0xFF000000),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
