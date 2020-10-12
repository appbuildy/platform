import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/properties/SchemaFontWeightProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson() maps to JSON', () {
    final fontWeight = SchemaFontWeightProperty('FontWeight', FontWeight.w100);
    expect(fontWeight.toJson()['value'], equals(FontWeight.w100.index));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> jsonTarget = {
      'name': 'FONT W E I G H T',
      'value': '0',
      'propertyClass': 'SchemaFontWeightProperty'
    };

    final fontWeight = SchemaFontWeightProperty.fromJson(jsonTarget);
    expect(fontWeight.value, equals(FontWeight.w100));
  });
}
