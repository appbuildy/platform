import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaFontWeightProperty extends SchemaNodeProperty {
  SchemaFontWeightProperty(String name, FontWeight value) : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaFontWeightProperty',
      'name': this.name,
      'value': this.value.index
    };
  }

  SchemaFontWeightProperty.fromJson(Map<String, dynamic> targetJson)
      : super('FontWeight', null) {
    this.name = targetJson['name'];
    final fontIndex = int.parse(targetJson['value']);
    final deserializedFont =
        FontWeight.values.firstWhere((font) => font.index == fontIndex);
    this.value = deserializedFont;
  }

  @override
  SchemaFontWeightProperty copy() {
    return SchemaFontWeightProperty(this.name, value);
  }
}
