import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMainAlignmentProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson() maps to JSON', () {
    final SchemaMainAlignmentProperty mainAlignProp =
        SchemaMainAlignmentProperty(
            'main axis align', MainAxisAlignment.spaceEvenly);

    final jsonMainAlignProp = mainAlignProp.toJson();

    expect(jsonMainAlignProp['name'], equals('main axis align'));
    expect(jsonMainAlignProp['value'], equals(5));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> jsonTarget = {
      'propertyClass': 'SchemaMainAlignmentProperty',
      'name': 'MainAlign',
      'value': '5',
    };

    final SchemaMainAlignmentProperty mainAlignProp =
        SchemaMainAlignmentProperty.fromJson(jsonTarget);
    expect(mainAlignProp.name, equals('MainAlign'));
    expect(mainAlignProp.value, equals(MainAxisAlignment.spaceEvenly));
  });
}
