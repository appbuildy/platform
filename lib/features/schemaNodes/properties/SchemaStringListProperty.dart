import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';

import 'SchemaListItemsProperty.dart';

const listColumnsSample = [
  'house_price',
  'house_address',
  'house_image',
  'house_description',
];

class SchemaStringListProperty
    extends SchemaNodeProperty<Map<String, SchemaListItemsProperty>> {
  static Future<SchemaStringListProperty> fromRemoteTable(
      IRemoteTable remoteTable) async {
    final records = await remoteTable.records();
    final result = SchemaStringListProperty(
        'Items', Map<String, SchemaListItemsProperty>());

    records['records'].forEach((record) {
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
      'house_first': SchemaListItemsProperty('house_first', {
        listColumnsSample[0]: ListItem(
            column: listColumnsSample[0], data: '\$539,990 | 3 Bedroom'),
        listColumnsSample[1]: ListItem(
          column: listColumnsSample[1],
          data: '885-891 3rd Ave, San Bruno, CA 94066',
        ),
        listColumnsSample[2]: ListItem(
          column: listColumnsSample[2],
          data:
              'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-1.2.1&auto=format&fit=crop&w=1280&q=80',
        ),
        listColumnsSample[3]:
            ListItem(column: listColumnsSample[3], data: "Lorem impsump"),
      }),
      'house_second': SchemaListItemsProperty('house_second', {
        listColumnsSample[0]: ListItem(
            column: listColumnsSample[0], data: '\$974,000 | 5 Bedroom'),
        listColumnsSample[1]: ListItem(
            column: listColumnsSample[1],
            data: '3939 4rd Ave, San Mateo, CA 94403'),
        listColumnsSample[2]: ListItem(
          column: listColumnsSample[2],
          data:
              'https://images.unsplash.com/photo-1591474200742-8e512e6f98f8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1280&q=80',
        ),
        listColumnsSample[3]:
            ListItem(column: listColumnsSample[3], data: "Lorem impsump"),
      }),
      'house_third': SchemaListItemsProperty('house_third', {
        listColumnsSample[0]: ListItem(
            column: listColumnsSample[0], data: '\$840,900 | 4 Bedroom'),
        listColumnsSample[1]: ListItem(
            column: listColumnsSample[1],
            data: '2730 Summit Dr, Palo Alto, CA 94010'),
        listColumnsSample[2]: ListItem(
          column: listColumnsSample[2],
          data:
              'https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1280&q=80',
        ),
        listColumnsSample[3]:
            ListItem(column: listColumnsSample[3], data: "Lorem impsump"),
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
      innerValue['$key'] =
          SchemaListItemsProperty.fromJson(schemaListItemsTargetJson);
    });

    this.value = innerValue;
  }

  @override
  SchemaStringListProperty copy() {
    return SchemaStringListProperty(this.name, this.value);
  }
}
