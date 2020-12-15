part of 'shared_widgets.dart';

class SharedWidget {
  static SharedButton button({text = 'test'}) {
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

    return SharedButton(
        properties: properties, size: Offset(50, 100), theme: theme);
  }
}
