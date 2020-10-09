import 'dart:ui';

import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaFontWeightProperty extends SchemaNodeProperty {
  SchemaFontWeightProperty(String name, FontWeight value) : super(name, value);

  @override
  SchemaFontWeightProperty copy() {
    return SchemaFontWeightProperty(this.name, value);
  }
}
