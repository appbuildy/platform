import 'dart:convert';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaListOfStringsProperty extends SchemaNodeProperty<List<String>> {
  SchemaListOfStringsProperty(String name, List<String> value)
      : super(name, value);

  @override
  SchemaListOfStringsProperty copy() {
    return SchemaListOfStringsProperty(this.name, value);
  }

  Map<String, dynamic> toJson() {
    String convertedValue = jsonEncode(this.value);

    return {
      'propertyClass': 'SchemaListOfStringsProperty',
      'name': this.name,
      'value': convertedValue,
    };
  }

  SchemaListOfStringsProperty.fromJson(Map<String, dynamic> targetJson)
      : super('name', null) {
    this.name = targetJson['name'];
    this.value = jsonDecode(targetJson['value']).cast<String>();
  }
}
