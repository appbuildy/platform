import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class SchemaIconProperty extends SchemaNodeProperty<IconData> {
  SchemaIconProperty(String name, IconData value)
      : super(name: name, value: value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaIconProperty',
      'name': this.name,
      'value': {
        'codePoint': this.value.codePoint,
        'fontFamily': this.value.fontFamily,
        'fontPackage': this.value.fontPackage,
        'matchTextDirection': this.value.matchTextDirection,
      },
    };
  }

  SchemaIconProperty.fromJson(Map<String, dynamic> jsonTarget)
      : super(name: jsonTarget['name'] ?? 'Icon', value: null) {
    final jsonValue = jsonTarget['value'];
    final int iconDataCodePoint = int.parse(jsonValue['codePoint'].toString());
    final String iconDataFontFamily = jsonValue['fontFamily'];
    final String iconDataFontPackage = jsonValue['fontPackage'];
    final bool iconDataMatchTextDirection = jsonValue['matchTextDirection'];

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
