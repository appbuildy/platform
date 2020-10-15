import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson() maps JSON', () {
    final SchemaDoubleProperty doubleProp =
        SchemaDoubleProperty('Double', 322.0);
    final jsonIntProperty = doubleProp.toJson();
    expect(jsonIntProperty['value'], equals(322.0));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> targetJson = {
      'propertyClass': 'SchemaDoubleProperty',
      'name': 'Double',
      'value': '1337.0',
    };

    final intProp = SchemaDoubleProperty.fromJson(targetJson);
    expect(intProp.name, equals('Double'));
    expect(intProp.value, equals(1337.0));
  });
}
