import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaDoubleProperty extends SchemaNodeProperty<double> {
  SchemaDoubleProperty(String name, double value)
      : super(
          name: name,
          value: value,
        );

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaDoubleProperty',
      'name': this.name,
      'value': this.value,
    };
  }

  SchemaDoubleProperty.fromJson(Map<String, dynamic> targetJson)
      : super(
          name: targetJson['name'] ?? 'Double',
          value: double.tryParse(targetJson['value']?.toString() ?? ''),
        );

  @override
  SchemaDoubleProperty copy() {
    return SchemaDoubleProperty(this.name, value);
  }
}
