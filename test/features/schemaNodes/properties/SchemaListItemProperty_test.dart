import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson() maps to JSON', () {
    final SchemaListItemsProperty listItemsProp =
        SchemaListItemsProperty('lucky', {
      'restaurant_name':
          ListItem(column: 'restaurant_name', data: 'Lucky In The Kai'),
      'restaurant_rate':
          ListItem(column: 'restaurant_rate', data: 'Elite Restaurant'),
      'restaurant_url': ListItem(
          column: 'restaurant_url',
          data:
              'https://images.unsplash.com/photo-1579065693224-0a3abed6a058?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80'),
    });

    final jsonListItemProp = listItemsProp.toJson();

    expect(jsonListItemProp['name'], equals('lucky'));
    expect(jsonListItemProp['value']['restaurant_name'],
        equals({'column': 'restaurant_name', 'data': 'Lucky In The Kai'}));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> targetJson = {
      'propertyClass': 'SchemaListItemsProperty',
      'name': 'lucky',
      'value': {
        'restaurant_name': {
          'column': 'restaurant_name',
          'data': 'Lucky In The Kai'
        },
        'restaurant_rate': {
          'column': 'restaurant_rate',
          'data': 'Elite Restaurant'
        },
        'restaurant_url': {
          'column': 'restaurant_url',
          'data':
              'https://images.unsplash.com/photo-1579065693224-0a3abed6a058?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80',
        }
      }
    };

    final SchemaListItemsProperty listItemProp =
        SchemaListItemsProperty.fromJson(targetJson);
    expect(
        listItemProp.value['restaurant_rate'].data, equals('Elite Restaurant'));
  });
}
