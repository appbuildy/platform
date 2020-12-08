import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaIntProperty extends SchemaNodeProperty<int> {
  SchemaIntProperty(String name, int value) : super(name: name, value: value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaIntProperty',
      'name': this.name,
      'value': this.value,
    };
  }

  SchemaIntProperty.fromJson(Map<String, dynamic> targetJson)
      : super(
          name: targetJson['name'] ?? 'Int',
          value: int.tryParse(targetJson['value'].toString() ?? ''),
        );

  @override
  SchemaIntProperty copy() {
    return SchemaIntProperty(this.name, value);
  }
}
