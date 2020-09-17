import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';

Color getThemeColor(AppThemeStore themeStore, SchemaNodeProperty prop) {
  return themeStore.currentTheme.getThemePropByName(prop.value.name).color;
}
