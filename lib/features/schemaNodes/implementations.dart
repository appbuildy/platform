import 'package:flutter/material.dart';
import 'SchemaNodeProperty.dart';

abstract class DataContainer {
  Widget toWidgetWithReplacedData({ bool isPlayMode, String data });

  //Widget toEditOnlyStyle(Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo);
}