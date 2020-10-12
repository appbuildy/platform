import 'dart:ui';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class SchemaMyThemePropProperty extends SchemaNodeProperty<MyThemeProp> {
  SchemaMyThemePropProperty(String name, MyThemeProp value)
      : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaMyThemePropProperty',
      'name': this.name,
      'value': {
        'name': this.value.name,
        'color': this.value.color.value,
      }
    };
  }

  SchemaMyThemePropProperty.fromJson(Map<String, dynamic> jsonTarget)
    : super('my theme prop', null) {
    this.name = jsonTarget['name'];

    this.value = MyThemeProp(
      name: jsonTarget['value']['name'],
      color: Color(int.parse(jsonTarget['value']['color'])),
    );
  }

  @override
  SchemaMyThemePropProperty copy() {
    return SchemaMyThemePropProperty(this.name, value);
  }
}