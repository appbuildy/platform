import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaCrossAlignmentProperty
    extends SchemaNodeProperty<CrossAxisAlignment> {
  SchemaCrossAlignmentProperty(String name, CrossAxisAlignment value)
      : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaCrossAlignmentProperty',
      'name': this.name,
      'value': this.value.index,
    };
  }

  SchemaCrossAlignmentProperty.fromJson(Map<String, dynamic> jsonTarget)
      : super('CrossAlign', null) {
    this.name = jsonTarget['name'];

    final int crossAlignItemIndex = int.parse(jsonTarget['value'].toString());
    final CrossAxisAlignment crossAlignItem = CrossAxisAlignment.values
        .firstWhere((alignItem) => alignItem.index == crossAlignItemIndex);

    this.value = crossAlignItem;
  }

  @override
  SchemaCrossAlignmentProperty copy() {
    return SchemaCrossAlignmentProperty(this.name, value);
  }
}
