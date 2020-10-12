import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';


class SchemaListTemplateProperty extends SchemaNodeProperty<ListTemplate> {
  SchemaListTemplateProperty(String name, ListTemplate value) : super(name, value);

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'SchemaListTemplateProperty',
      'name': this.name,
      'value': this.value.getType().index,
    };
  }

  SchemaListTemplateProperty.fromJson(Map<String, dynamic> targetJson)
      : super('List template', null) {
    this.name = targetJson['name'];

    int index = int.parse(targetJson['value']);
    ListTemplateType type = ListTemplateType.values.firstWhere((type) => type.index == index);

    this.value = getListTemplateByType(type);
  }

  @override
  SchemaListTemplateProperty copy() {
    return SchemaListTemplateProperty(this.name, this.value);
  }
}