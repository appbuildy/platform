import 'package:flutter/material.dart';
import 'package:flutter_app/canvas/WidgetPosition.dart';

class WidgetWrapper {
  Widget flutterWidget;
  WidgetPosition position;

  WidgetWrapper({Widget flutterWidget, WidgetPosition position}) {
    this.flutterWidget = flutterWidget;
    this.position = position;
  }
}
