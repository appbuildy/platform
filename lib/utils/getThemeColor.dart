import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

Color getThemeColor(MyTheme theme, SchemaNodeProperty prop) {
  return theme.getThemePropByName(prop.value.name).color;
}
