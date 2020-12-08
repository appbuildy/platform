import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaMainAlignmentProperty
    extends SchemaNodeProperty<MainAxisAlignment> {
  SchemaMainAlignmentProperty(String name, MainAxisAlignment value)
      : super(name: name, value: value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaMainAlignmentProperty',
      'name': this.name,
      'value': this.value.index,
    };
  }

  SchemaMainAlignmentProperty.fromJson(Map<String, dynamic> jsonTarget)
      : super(name: jsonTarget['name'] ?? 'MainAlign', value: null) {
    final int mainAlignItemIndex = int.parse(jsonTarget['value'].toString());
    final MainAxisAlignment mainAlignItem =
        MainAxisAlignment.values.length > mainAlignItemIndex
            ? MainAxisAlignment.values[mainAlignItemIndex]
            : null;

    this.value = mainAlignItem;
  }

  @override
  SchemaMainAlignmentProperty copy() {
    return SchemaMainAlignmentProperty(this.name, value);
  }
}
