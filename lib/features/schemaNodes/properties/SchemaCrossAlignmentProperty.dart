import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaCrossAlignmentProperty
    extends SchemaNodeProperty<CrossAxisAlignment> {
  SchemaCrossAlignmentProperty(String name, CrossAxisAlignment value)
      : super(
          name: name,
          value: value,
        );

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaCrossAlignmentProperty',
      'name': this.name,
      'value': this.value.index,
    };
  }

  SchemaCrossAlignmentProperty.fromJson(Map<String, dynamic> jsonTarget)
      : super(
          name: jsonTarget['name'] ?? 'CrossAlign',
          value: CrossAxisAlignment
              .values[int.tryParse(jsonTarget['value']?.toString() ?? '') ?? 0],
        );

  @override
  SchemaCrossAlignmentProperty copy() {
    return SchemaCrossAlignmentProperty(this.name, value);
  }
}
