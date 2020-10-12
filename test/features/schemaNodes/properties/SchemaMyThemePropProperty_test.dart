import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  test('toJson() maps JSON', () {
    final SchemaMyThemePropProperty myThemeProp = SchemaMyThemePropProperty('Name', MyThemeProp(name: 'name', color: Color(0xFF000000)));
    final jsonMyThemeProp = myThemeProp.toJson();

    expect(jsonMyThemeProp['name'], equals(myThemeProp.name));
    expect(jsonMyThemeProp['value']['name'], equals(myThemeProp.value.name));
    expect(jsonMyThemeProp['value']['color'], equals(myThemeProp.value.color.value));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> jsonTarget = {
      'propertyClass': 'SchemaMyThemePropProperty',
      'name': 'themename',
      'value': {
        'name': 'colorName',
        'color': Color(0xFF000000).value.toString(),
      },
    };

    final SchemaMyThemePropProperty myThemeProp = SchemaMyThemePropProperty.fromJson(jsonTarget);
    expect(myThemeProp.name, equals('themename'));
    expect(myThemeProp.value.name, equals('colorName'));
    expect(myThemeProp.value.color, equals(Color(0xFF000000)));
  });
}
