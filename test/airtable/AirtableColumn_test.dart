import 'package:flutter_app/features/airtable/AirtableAttribute.dart';
import 'package:flutter_app/features/airtable/AirtableColumn.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  test('.add adds element to list', () {
    final column = AirtableColumn('Col');
    final attr = AirtableAttribute('123', 'Col');

    column.add(attr);
    expect(column.list.length, equals(1));
  });
}
