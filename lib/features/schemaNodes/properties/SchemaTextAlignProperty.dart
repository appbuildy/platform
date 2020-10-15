import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaTextAlignProperty extends SchemaNodeProperty<TextAlign> {
  SchemaTextAlignProperty(String name, TextAlign value) : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaTextAlignProperty',
      'name': this.name,
      'value': this.value.index,
    };
  }

  SchemaTextAlignProperty.fromJson(Map<String, dynamic> jsonTarget)
      : super('Text align', null) {
    this.name = jsonTarget['name'];

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
