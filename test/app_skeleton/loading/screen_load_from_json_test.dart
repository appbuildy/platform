import 'dart:convert';

import 'package:flutter_app/app_skeleton/loading/screen_load_from_json.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String jsonString =
      '{"id":{"value":"9CQUD8pK1zNv0wNgzZvQrQUuXBhniV"},"name":"Home","components":[{"size":{"x":343,"y":50},"type":"SchemaNodeType.button","actions":{"Tap":{"type":"SchemaActionType.goToScreen","value":{"value":"9CQUD8pK1zNv0wNgzZvQrQUuXBhniV"},"action":"Tap","propertyClass":"GoToScreenAction"}},"position":{"x":20,"y":270.0546875},"properties":{"Text":{"name":"Text","value":"Button","propertyClass":"SchemaStringProperty"},"Border":{"name":"Border","value":false,"propertyClass":"SchemaBoolProperty"},"FontSize":{"name":"FontSize","value":16,"propertyClass":"SchemaIntProperty"},"BoxShadow":{"name":"BoxShadow","value":false,"propertyClass":"SchemaBoolProperty"},"FontColor":{"name":"FontColor","value":{"name":"general_inverted","color":4294572537},"propertyClass":"SchemaMyThemePropProperty"},"FontWeight":{"name":"FontWeight","value":4,"propertyClass":"SchemaFontWeightProperty"},"BorderColor":{"name":"BorderColor","value":{"name":"primary","color":4278221567},"propertyClass":"SchemaMyThemePropProperty"},"BorderWidth":{"name":"BorderWidth","value":1,"propertyClass":"SchemaIntProperty"},"BoxShadowBlur":{"name":"BoxShadowBlur","value":5,"propertyClass":"SchemaIntProperty"},"MainAlignment":{"name":"MainAlignment","value":2,"propertyClass":"SchemaMainAlignmentProperty"},"BoxShadowColor":{"name":"BoxShadowColor","value":{"name":"general","color":4279308561},"propertyClass":"SchemaMyThemePropProperty"},"CrossAlignment":{"name":"CrossAlignment","value":2,"propertyClass":"SchemaCrossAlignmentProperty"},"BackgroundColor":{"name":"BackgroundColor","value":{"name":"primary","color":4278221567},"propertyClass":"SchemaMyThemePropProperty"},"BoxShadowOpacity":{"name":"BoxShadowOpacity","value":0.5,"propertyClass":"SchemaDoubleProperty"},"BorderRadiusValue":{"name":"BorderRadiusValue","value":9,"propertyClass":"SchemaIntProperty"}}}],"detailedInfo":null,"backgroundColor":{"red":255,"blue":255,"name":"background","green":255,"opacity":1},"bottomTabsVisible":true}';
  Map<String, dynamic> jsonScreen = json.decode(jsonString);

  test('.load() loads screen and components', () {
    var loader = ScreenLoadFromJson(jsonScreen);
    var screen = loader.load();
    expect(screen.widgets.first, isA<WidgetDecorator>());
  });
}
