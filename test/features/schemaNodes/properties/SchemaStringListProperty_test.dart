import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson() maps to JSON', () {
    final SchemaStringListProperty stringListProp = SchemaStringListProperty(
      'Items',
      {
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
      },
    );

    final jsonStringListProp = stringListProp.toJson();

    expect(jsonStringListProp['name'], equals('Items'));
    expect(jsonStringListProp['value']['lucky']['name'], equals('lucky'));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> targetJson = {
      'propertyClass': 'SchemaStringListProperty',
      "name": "Items",
      "value": {
        "mac": {
          "name": "mac",
          "value": {
            "restaurant_name": {
              "column": "restaurant_name",
              "data": "McDonalds"
            },
            "restaurant_rate": {
              "column": "restaurant_rate",
              "data": "Fast Food"
            },
            "restaurant_url": {
              "column": "restaurant_url",
              "data":
                  "https://images.unsplash.com/photo-1552895638-f7fe08d2f7d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80"
            }
          }
        },
        "bk": {
          "name": "mac",
          "value": {
            "restaurant_name": {
              "column": "restaurant_name",
              "data": "Burger King"
            },
            "restaurant_rate": {
              "column": "restaurant_rate",
              "data": "Fast Food"
            },
            "restaurant_url": {
              "column": "restaurant_url",
              "data":
                  "https://images.unsplash.com/photo-1528669826296-dbd6f641707d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80"
            }
          }
        },
        "lucky": {
          "name": "lucky",
          "value": {
            "restaurant_name": {
              "column": "restaurant_name",
              "data": "Lucky In The Kai"
            },
            "restaurant_rate": {
              "column": "restaurant_rate",
              "data": "Elite Restaurant"
            },
            "restaurant_url": {
              "column": "restaurant_url",
              "data":
                  "https://images.unsplash.com/photo-1579065693224-0a3abed6a058?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80"
            }
          }
        }
      }
    };

    final SchemaStringListProperty stringListProp =
        SchemaStringListProperty.fromJson(targetJson);
    expect(stringListProp.name, equals('Items'));
    expect(stringListProp.value['lucky'].name, equals('lucky'));
  });
}
