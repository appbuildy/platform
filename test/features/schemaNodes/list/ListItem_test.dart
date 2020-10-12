import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson() maps to JSON', () {
    final ListItem listItem = ListItem(column: 'q w e', data: 'd a t a');

    final jsonListItem = listItem.toJson();
    expect(jsonListItem['column'], equals('q w e'));
    expect(jsonListItem['data'], equals('d a t a'));
  });

  test('fromJson() deserialization', () {
    final Map<String, String> targetJson = {
      'column': 'col',
      'data': 'dat a',
    };

    final ListItem listItem = ListItem.fromJson(targetJson);

    expect(listItem.column, equals('col'));
    expect(listItem.data, equals('dat a'));
  });
}
