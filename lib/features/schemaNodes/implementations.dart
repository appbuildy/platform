import 'package:flutter/material.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'SchemaNodeProperty.dart';

abstract class DataContainer {
  Widget toWidgetWithReplacedData(
      {bool isPlayMode, String data, MyTheme theme = null});

  Widget toEditOnlyStyle(
      Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo);
}
