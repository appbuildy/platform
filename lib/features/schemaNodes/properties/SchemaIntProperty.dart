import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaIntProperty extends SchemaNodeProperty<int> {
  SchemaIntProperty(String name, int value) : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaIntProperty',
      'name': this.name,
      'value': this.value,
    };
  }

  SchemaIntProperty.fromJson(Map<String, dynamic> targetJson)
    : super('Int', null) {
    this.name = targetJson['name'];
    this.value = int.parse(targetJson['value']);
  }

  @override
  SchemaIntProperty copy() {
    return SchemaIntProperty(this.name, value);
  }
}