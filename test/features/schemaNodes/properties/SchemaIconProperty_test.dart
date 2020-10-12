import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIconProperty.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  // FontAwesomeIcons.adjust:
  final IconData adjustIcon = IconData(
    0xf042,
    fontFamily: 'FontAwesomeSolid',
    fontPackage: 'font_awesome_flutter',
    matchTextDirection: false,
  );
  test('toJson() maps to JSON', () {

    final SchemaIconProperty iconProp = SchemaIconProperty('Icon', FontAwesomeIcons.adjust);
    final jsonIconProp = iconProp.toJson();
    expect(jsonIconProp['name'], equals(iconProp.name));

    final jsonIconPropValue = jsonIconProp['value'];

    expect(jsonIconPropValue['codePoint'], equals(iconProp.value.codePoint));
    expect(jsonIconPropValue['fontFamily'], equals(iconProp.value.fontFamily));
    expect(jsonIconPropValue['fontPackage'], equals(iconProp.value.fontPackage));
    expect(jsonIconPropValue['matchTextDirection'], equals(iconProp.value.matchTextDirection));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> jsonTarget = {
      'propertyClass': 'SchemaIconProperty',
      'name': 'IC ON',
      'value': {
        'codePoint': '0xf042',
        'fontFamily': 'FontAwesomeSolid',
        'fontPackage': 'font_awesome_flutter',
        'matchTextDirection': false,
      },
    };

    final SchemaIconProperty iconProp =  SchemaIconProperty.toJson(jsonTarget);
    expect(iconProp.name, equals('IC ON'));

    final IconData iconPropValue = iconProp.value;
    print(iconPropValue.codePoint);
    expect(iconPropValue, equals(adjustIcon));
  });
}
