import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaColorProperty extends SchemaNodeProperty<Color> {
  SchemaColorProperty(
    String name,
    Color value,
  ) : super(name: name, value: value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaColorProperty',
      'name': this.name,
      'value': this.value.value,
    };
  }

  SchemaColorProperty.fromJson(Map<String, dynamic> jsonTarget)
      : super(
          name: jsonTarget['name'] ?? 'Color',
          value: Color(int.parse(jsonTarget['value'])),
        );

  @override
  SchemaColorProperty copy() {
    return SchemaColorProperty(this.name, value);
  }
}
