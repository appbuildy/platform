import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaStringProperty extends SchemaNodeProperty<String> {
  SchemaStringProperty(String name, String value) : super(name, value);

  @override
  SchemaStringProperty copy() {
    return SchemaStringProperty(this.name, value);
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaStringProperty',
      'name': this.name,
      'value': this.value,
    };
  }

  SchemaStringProperty.fromJson(Map<String, dynamic> targetJson)
      : super('name', null) {
    this.name = targetJson['name'];
    this.value = targetJson['value'];
  }
}
