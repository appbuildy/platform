import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';

import 'SchemaListItemsProperty.dart';

class SchemaStringListProperty extends SchemaNodeProperty<Map<String, SchemaListItemsProperty>> {
  static Future<SchemaStringListProperty> fromRemoteTable(IRemoteTable remoteTable) async {
    final records = await remoteTable.records();
    final result = SchemaStringListProperty('Items', Map<String, SchemaListItemsProperty>());

    records['records'].forEach((record) {
      print(record);
      final mapProps = Map<String, ListItem>();
      final prop = SchemaListItemsProperty(record['id'], mapProps);
      record['fields'].forEach((key, value) {
        mapProps[key] = ListItem(column: key, data: value);
      });
      result.value[record['id']] = prop;
    });
    return result;
  }

  factory SchemaStringListProperty.sample() {
    return SchemaStringListProperty('Items', {
      // пример дата айтемов-row с сгенеренными
      'mac': SchemaListItemsProperty('mac', {
        'restaurant_name':
        ListItem(column: 'restaurant_name', data: 'McDonalds'),
        'restaurant_rate':
        ListItem(column: 'restaurant_rate', data: 'Fast Food'),
        'restaurant_url': ListItem(
            column: 'restaurant_url',
            data:
            'https://images.unsplash.com/photo-1552895638-f7fe08d2f7d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80'),
      }),
      'bk': SchemaListItemsProperty('mac', {
        'restaurant_name':
        ListItem(column: 'restaurant_name', data: 'Burger King'),
        'restaurant_rate':
        ListItem(column: 'restaurant_rate', data: 'Fast Food'),
        'restaurant_url': ListItem(
            column: 'restaurant_url',
            data:
            'https://images.unsplash.com/photo-1528669826296-dbd6f641707d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80'),
      }),
      'lucky': SchemaListItemsProperty('lucky', {
        'restaurant_name':
        ListItem(column: 'restaurant_name', data: 'Lucky In The Kai'),
        'restaurant_rate':
        ListItem(column: 'restaurant_rate', data: 'Elite Restaurant'),
        'restaurant_url': ListItem(
            column: 'restaurant_url',
            data:
            'https://images.unsplash.com/photo-1579065693224-0a3abed6a058?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80'),
      }),
    });
  }

  SchemaStringListProperty(
      String name, Map<String, SchemaListItemsProperty> value)
      : super(name, value);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> outValue = {};

    this.value.forEach((key, val) {
      outValue['$key'] = val.toJson();
    });

    return {
      'propertyClass': 'SchemaStringListProperty',
      'name': this.name,
      'value': outValue,
    };
  }

  SchemaStringListProperty.fromJson(Map<String, dynamic> targetJson)
    : super('String List Property', null) {
    this.name = targetJson['name'];

    Map<String, SchemaListItemsProperty> innerValue = {};

    targetJson['value'].forEach((key, schemaListItemsTargetJson) {
      innerValue['$key'] = SchemaListItemsProperty.fromJson(schemaListItemsTargetJson);
    });

    this.value = innerValue;
  }

  @override
  SchemaStringListProperty copy() {
    return SchemaStringListProperty(this.name, this.value);
  }
}