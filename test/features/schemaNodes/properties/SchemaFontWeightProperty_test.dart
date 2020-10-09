import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/properties/SchemaFontWeightProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson maps to JSON', () {
    final fontWeight = SchemaFontWeightProperty('FontWeight', FontWeight.w100);
    expect(fontWeight.toJson()['value'], equals('FontWeight.w100'));
  });
}
