import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaBoolProperty extends SchemaNodeProperty<bool> {
  SchemaBoolProperty(String name, bool value) : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaBoolProperty',
      'name': this.name,
      'value': this.value,
    };
  }

  SchemaBoolProperty.fromJson(Map<String, dynamic> targetJson)
      : super('Bool', null) {
    this.name = targetJson['name'];
    this.value = targetJson['value'];
  }

  @override
  SchemaBoolProperty copy() {
    return SchemaBoolProperty(this.name, value);
  }
}
