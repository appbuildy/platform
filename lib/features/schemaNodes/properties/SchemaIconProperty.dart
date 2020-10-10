
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaIconProperty extends SchemaNodeProperty<IconData> {
  SchemaIconProperty(String name, IconData value) : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaIconProperty',
      'name': this.name,
      'value': {
        'codePoint': this.value.codePoint,
        'fontFamily': this.value.fontFamily,
        'fontPackage': this.value.fontPackage,
        'matchTextDirection': this.value.matchTextDirection ? 1 : 0,
      },
    };
  }

  SchemaIconProperty.toJson(Map<String, dynamic> jsonTarget)
    : super('Icon', null) {
    this.name = jsonTarget['name'];

    final jsonValue = jsonTarget['value'];
    final int iconDataCodePoint = int.parse(jsonValue['codePoint']);
    final String iconDataFontFamily = jsonValue['fontFamily'];
    final String iconDataFontPackage = jsonValue['fontPackage'];
    final bool iconDataMatchTextDirection = int.parse(jsonValue['matchTextDirection']) == 1;

    this.value = IconData(
      iconDataCodePoint,
      fontFamily: iconDataFontFamily,
      fontPackage: iconDataFontPackage,
      matchTextDirection: iconDataMatchTextDirection,
    );
  }

  @override
  SchemaIconProperty copy() {
    return SchemaIconProperty(this.name, this.value);
  }
}