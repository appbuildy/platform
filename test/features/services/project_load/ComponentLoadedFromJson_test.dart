import 'dart:convert';

import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/services/project_load/ComponentLoadedFromJson.dart';
import 'package:flutter_app/features/services/projects/LoadedProject.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String jsonComponent =
      '{"size":{"x":343,"y":50},"type":"SchemaNodeType.button","actions":{"Tap":{"type":"SchemaActionType.goToScreen","value":null,"action":"Tap"}},"position":{"x":0,"y":169.57421875},"properties":{"Text":{"name":"Text","value":"Button","propertyClass":"SchemaStringProperty"},"Border":{"name":"Border","value":false,"propertyClass":"SchemaBoolProperty"},"FontSize":{"name":"FontSize","value":16,"propertyClass":"SchemaIntProperty"},"BoxShadow":{"name":"BoxShadow","value":false,"propertyClass":"SchemaBoolProperty"},"FontColor":{"name":"FontColor","value":{"name":"generalInverted","color":4294572537},"propertyClass":"SchemaMyThemePropProperty"},"FontWeight":{"name":"FontWeight","value":4,"propertyClass":"SchemaFontWeightProperty"},"BorderColor":{"name":"BorderColor","value":{"name":"primary","color":4278221567},"propertyClass":"SchemaMyThemePropProperty"},"BorderWidth":{"name":"BorderWidth","value":1,"propertyClass":"SchemaIntProperty"},"BoxShadowBlur":{"name":"BoxShadowBlur","value":5,"propertyClass":"SchemaIntProperty"},"MainAlignment":{"name":"MainAlignment","value":2,"propertyClass":"SchemaMainAlignmentProperty"},"BoxShadowColor":{"name":"BoxShadowColor","value":{"name":"general","color":4279308561},"propertyClass":"SchemaMyThemePropProperty"},"CrossAlignment":{"name":"CrossAlignment","value":2,"propertyClass":"SchemaCrossAlignmentProperty"},"BackgroundColor":{"name":"BackgroundColor","value":{"name":"primary","color":4278221567},"propertyClass":"SchemaMyThemePropProperty"},"BoxShadowOpacity":{"name":"BoxShadowOpacity","value":0.5,"propertyClass":"SchemaDoubleProperty"},"BorderRadiusValue":{"name":"BorderRadiusValue","value":9,"propertyClass":"SchemaIntProperty"}}}';
  Map<String, dynamic> decodedComponent = json.decode(jsonComponent);
  SchemaNode loaded = ComponentLoadedFromJson(decodedComponent).load();

  test('load() loads size', () async {
    expect(loaded.size.dx, 343);
    expect(loaded.size.dy, 50);
  });
}
