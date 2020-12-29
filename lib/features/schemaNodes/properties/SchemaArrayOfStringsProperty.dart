import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaListOfStringsProperty extends SchemaNodeProperty<List<String>> {
  SchemaListOfStringsProperty(String name, List<String> value)
      : super(name, value);

  @override
  SchemaListOfStringsProperty copy() {
    return SchemaListOfStringsProperty(this.name, value);
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaListOfStringsProperty',
      'name': this.name,
      'value': this.value.toString(),
    };
  }

  SchemaListOfStringsProperty.fromJson(Map<String, dynamic> targetJson)
      : super('name', null) {
    this.name = targetJson['name'];
    this.value = targetJson['value'];
  }
}
