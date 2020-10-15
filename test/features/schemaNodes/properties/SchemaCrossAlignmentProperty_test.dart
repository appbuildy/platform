import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaCrossAlignmentProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson() maps to JSON', () {
    final SchemaCrossAlignmentProperty crossAlignProp =
        SchemaCrossAlignmentProperty(
            'cross axis align', CrossAxisAlignment.center);

    final jsonCrossAlignProp = crossAlignProp.toJson();

    expect(jsonCrossAlignProp['name'], equals('cross axis align'));
    expect(jsonCrossAlignProp['value'], equals(2));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> jsonTarget = {
      'propertyClass': 'SchemaCrossAlignmentProperty',
      'name': 'CrossAlign',
      'value': '2',
    };

    final SchemaCrossAlignmentProperty crossAlignProp =
        SchemaCrossAlignmentProperty.fromJson(jsonTarget);
    expect(crossAlignProp.name, equals('CrossAlign'));
    expect(crossAlignProp.value, equals(CrossAxisAlignment.center));
  });
}
