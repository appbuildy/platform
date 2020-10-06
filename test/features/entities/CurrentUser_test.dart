import 'package:flutter_app/features/airtable/AirtableAttribute.dart';
import 'package:flutter_app/features/airtable/AirtableColumn.dart';
import 'package:flutter_app/features/airtable/RemoteList.dart';
import 'package:flutter_app/features/entities/CurrentUser.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

final mockClient = MockClient();
final responseBody = '{ "tables" : [{ "name": "table 1" }] }';

void main() {
  test('tables()', () async {
    final dataUrl = 'https://backend.com/me';

    when(mockClient.get(dataUrl))
        .thenAnswer((_) async => http.Response(responseBody, 200));

    final CurrentUser user = CurrentUser('Sanek', '1231', dataUrl);
    final tables = await user.tables(mockClient);
    expect(tables.first, equals('table 1'));
  });
}
