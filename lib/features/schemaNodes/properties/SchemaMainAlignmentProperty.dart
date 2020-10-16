import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaMainAlignmentProperty
    extends SchemaNodeProperty<MainAxisAlignment> {
  SchemaMainAlignmentProperty(String name, MainAxisAlignment value)
      : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaMainAlignmentProperty',
      'name': this.name,
      'value': this.value.index,
    };
  }

  SchemaMainAlignmentProperty.fromJson(Map<String, dynamic> jsonTarget)
      : super('MainAlign', null) {
    this.name = jsonTarget['name'];

    final int mainAlignItemIndex = int.parse(jsonTarget['value'].toString());
    final MainAxisAlignment mainAlignItem = MainAxisAlignment.values
        .firstWhere((alignItem) => alignItem.index == mainAlignItemIndex);

    this.value = mainAlignItem;
  }

  @override
  SchemaMainAlignmentProperty copy() {
    return SchemaMainAlignmentProperty(this.name, value);
  }
}
