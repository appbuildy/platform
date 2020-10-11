import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListTemplateProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson maps to JSON', () {
    final SchemaListTemplateProperty listTemplateProp = SchemaListTemplateProperty('prop', getListTemplateByType(ListTemplateType.cards));
    final jsonListTemplateProp = listTemplateProp.toJson();

    expect(jsonListTemplateProp['name'], equals(listTemplateProp.name));
    expect(jsonListTemplateProp['value'], equals(ListTemplateType.cards.index));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> targetJson = {
      'propertyClass': 'SchemaListTemplateProperty',
      'name': 'ListName',
      'value': '${ListTemplateType.simple.index}',
    };

    final SchemaListTemplateProperty listTemplateProp = SchemaListTemplateProperty.fromJson(targetJson);

    expect(listTemplateProp.name, equals('ListName'));
    expect(listTemplateProp.value.getType(), equals(ListTemplateType.simple));
  });
}
