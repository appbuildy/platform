import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaTextAlignProperty extends SchemaNodeProperty<TextAlign> {
  SchemaTextAlignProperty(String name, TextAlign value)
      : super(
          name: name,
          value: value,
        );

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaTextAlignProperty',
      'name': this.name,
      'value': this.value.index,
    };
  }

  SchemaTextAlignProperty.fromJson(Map<String, dynamic> jsonTarget)
      : super(
          name: jsonTarget['name'] ?? 'Text align',
          value: null,
        ) {
    final int textAlignItemIndex = int.parse(jsonTarget['value']);
    final TextAlign textAlignItem = TextAlign.values
        .firstWhere((alignItem) => alignItem.index == textAlignItemIndex);

    this.value = textAlignItem;
  }

  @override
  SchemaTextAlignProperty copy() {
    return SchemaTextAlignProperty(this.name, value);
  }
}
