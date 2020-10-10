import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaDoubleProperty extends SchemaNodeProperty<double> {
  SchemaDoubleProperty(String name, double value) : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaDoubleProperty',
      'name': this.name,
      'value': this.value,
    };
  }

  SchemaDoubleProperty.fromJson(Map<String, dynamic> targetJson)
      : super('Double', null) {
    this.name = targetJson['name'];
    this.value = double.parse(targetJson['value']);
  }

  @override
  SchemaDoubleProperty copy() {
    return SchemaDoubleProperty(this.name, value);
  }
}