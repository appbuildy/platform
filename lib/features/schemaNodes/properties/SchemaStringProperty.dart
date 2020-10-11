import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaStringProperty extends SchemaNodeProperty {
  SchemaStringProperty(String name, String value) : super(name, value);

  @override
  SchemaStringProperty copy() {
    return SchemaStringProperty(this.name, value);
  }

  SchemaStringProperty.fromJson(Map<String, dynamic> targetJson)
      : super('name', null) {
    this.name = targetJson['name'];
    this.value = targetJson['value'];
  }
}
