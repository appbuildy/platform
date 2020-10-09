import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaFontWeightProperty extends SchemaNodeProperty {
  SchemaFontWeightProperty(String name, FontWeight value) : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaFontWeightProperty',
      'name': this.name,
      'value': this.value.toString()
    };
  }

  @override
  SchemaFontWeightProperty copy() {
    return SchemaFontWeightProperty(this.name, value);
  }
}
