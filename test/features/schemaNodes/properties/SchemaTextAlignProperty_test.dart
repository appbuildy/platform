import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/properties/SchemaTextAlignProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson() maps to JSON', () {
    final SchemaTextAlignProperty textAlignProp = SchemaTextAlignProperty('Text align', TextAlign.justify);
    final jsonTextAlignProp = textAlignProp.toJson();
    expect(jsonTextAlignProp['name'], equals('Text align'));
    expect(jsonTextAlignProp['value'], equals(3));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> jsonTarget = {
      'propertyClass': 'SchemaTextAlignProperty',
      'name': 'Say my name',
      'value': '3',
    };

    final SchemaTextAlignProperty textAlignProp = SchemaTextAlignProperty.fromJson(jsonTarget);
    expect(textAlignProp.name, equals('Say my name'));
    expect(textAlignProp.value, equals(TextAlign.justify));
  });
}
