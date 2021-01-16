import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/previewScreens/phonescreen_app.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:qr_flutter/qr_flutter.dart';

var url = window.location.href;

class PhoneScreenWithDescription extends StatelessWidget {
  final Size targetScreenSize;
  final Size screenSizeInConstructor;
  final double navHeight;
  final Widget nav;
  final List<WidgetDecorator> widgets;

  PhoneScreenWithDescription({
    @required this.targetScreenSize,
    @required this.screenSizeInConstructor,
    @required this.navHeight,
    @required this.nav,
    @required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://www.appbuildy.com/images/hero_bg.svg',
                  ))),
          width: double.infinity,
          child: Center(
            child: Container(
              width: screenSizeInConstructor.width * 2,
              child: Row(
                children: [
                  PhoneScreen(
                    targetScreenSize: targetScreenSize,
                    screenSizeInConstructor: screenSizeInConstructor,
                    navHeight: navHeight,
                    nav: nav,
                    widgets: widgets,
                  ),
                  SizedBox(width: 40),
                  Flexible(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: QrImage(
                              data: window.location.href,
                              version: QrVersions.auto,
                              padding: EdgeInsets.zero,
                              size: 130,
                              gapless: true,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                              'Point your camera\nto the QR code\nto install the app')
                        ],
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Image.network('https://www.appbuildy.com/images/logotype.svg'),
        ),
      ],
    );
  }
}
