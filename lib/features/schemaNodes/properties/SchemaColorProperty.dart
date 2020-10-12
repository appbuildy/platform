import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaColorProperty extends SchemaNodeProperty<Color> {
  SchemaColorProperty(String name, Color value) : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaColorProperty',
      'name': this.name,
      'value': this.value.value,
    };
  }

  SchemaColorProperty.fromJson(Map<String, dynamic> jsonTarget)
    : super('Color', null) {
    this.name = jsonTarget['name'];
    this.value = Color(int.parse(jsonTarget['value']));
  }

  @override
  SchemaColorProperty copy() {
    return SchemaColorProperty(this.name, value);
  }
}