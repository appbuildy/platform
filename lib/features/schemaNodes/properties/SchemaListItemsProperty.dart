import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';

class SchemaListItemsProperty
    extends SchemaNodeProperty<Map<String, ListItem>> {
  SchemaListItemsProperty(String name, Map<String, ListItem> value)
      : super(name, value);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> outValue = {};

    this.value.forEach((key, val) {
      outValue['$key'] = val.toJson();
    });

    return {
      'propertyClass': 'SchemaListItemsProperty',
      'name': this.name,
      'value': outValue,
    };
  }

  SchemaListItemsProperty.fromJson(Map<String, dynamic> targetJson)
      : super('List Item Property', null) {
    this.name = targetJson['name'];

    Map<String, ListItem> innerValue = {};

    targetJson['value'].forEach((key, listItemTargetJson) {
      innerValue['$key'] = ListItem.fromJson(listItemTargetJson);
    });

    this.value = innerValue;
  }

  @override
  SchemaListItemsProperty copy() {
    return SchemaListItemsProperty(this.name, value);
  }
}
