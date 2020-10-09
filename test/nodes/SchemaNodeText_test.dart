import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('copy()', () {
    final props = Map<String, SchemaNodeProperty>();
    props['Text'] = SchemaStringProperty('Text', '42');
    final text = SchemaNodeText(position: Offset(1, 2), properties: props);

    expect(text.copy(), isNotNull);
  });
}
