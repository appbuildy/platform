import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaCrossAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaFontWeightProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMainAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

import 'button.dart';

class SharedWidget {
  static Button button({text = 'test'}) {
    var theme = MyThemes.allThemes['blue'];
    Map<String, SchemaNodeProperty> properties = {
      'Text': SchemaStringProperty('Text', text ?? 'Button'),
      'FontColor':
          SchemaMyThemePropProperty('FontColor', theme.generalInverted),
      'FontSize': SchemaIntProperty('FontSize', 16),
      'FontWeight': SchemaFontWeightProperty('FontWeight', FontWeight.w500),
      'MainAlignment': SchemaMainAlignmentProperty(
          'MainAlignment', MainAxisAlignment.center),
      'CrossAlignment': SchemaCrossAlignmentProperty(
          'CrossAlignment', CrossAxisAlignment.center),
      'Border': SchemaBoolProperty('Border', false),
      'BorderColor': SchemaMyThemePropProperty('BorderColor', theme.primary),
      'BorderWidth': SchemaIntProperty('BorderWidth', 1),
      'BackgroundColor':
          SchemaMyThemePropProperty('BackgroundColor', theme.primary),
      'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 9),
      'BoxShadow': SchemaBoolProperty('BoxShadow', false),
      'BoxShadowColor':
          SchemaMyThemePropProperty('BoxShadowColor', theme.general),
      'BoxShadowBlur': SchemaIntProperty('BoxShadowBlur', 5),
      'BoxShadowOpacity': SchemaDoubleProperty('BoxShadowOpacity', 0.5),
    };

    return Button(properties: properties, size: Offset(50, 100), theme: theme);
  }
}
