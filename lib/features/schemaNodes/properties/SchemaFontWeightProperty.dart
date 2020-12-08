import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaFontWeightProperty extends SchemaNodeProperty<FontWeight> {
  SchemaFontWeightProperty(String name, FontWeight value)
      : super(
          name: name,
          value: value,
        );

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaFontWeightProperty',
      'name': this.name,
      'value': this.value.index
    };
  }

  SchemaFontWeightProperty.fromJson(Map<String, dynamic> targetJson)
      : super(name: targetJson['name'] ?? 'FontWeight', value: null) {
    final fontIndex = int.parse(targetJson['value'].toString());
    final deserializedFont = fontIndex < FontWeight.values.length
        ? FontWeight.values[fontIndex]
        : null;
    this.value = deserializedFont;
  }

  @override
  SchemaFontWeightProperty copy() {
    return SchemaFontWeightProperty(this.name, value);
  }
}
