import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  group('record', () {
    test('requests record', () async {
      final mockClient = MockClient();
      final responseBody =
          '{ "id": "recAn1qY01DxTcfJj", "fields": { "Name": "Test", "Button": "422" }, "createdTime": "2020-09-02T15:21:46.000Z" }';

      when(mockClient.get('https://api.airtable.com/v0/322/t1/1'))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      final client = Client(
          table: 't1', apiKey: '123', base: '322', httpClient: mockClient);
      final record = await client.record('1');
      expect(record['id'], equals('recAn1qY01DxTcfJj'));
    });
  });
  group('records()', () {
    test('requests records', () async {
      final mockClient = MockClient();
      final responseString =
          '{"records":[{"id":"recAn1qY01DxTcfJj","fields":{"Button":"422","Name":"Test"},"createdTime":"2020-09-02T15:21:46.000Z"},{"id":"recN1pVMNH0S0QulX","fields":{},"createdTime":"2020-09-02T15:21:46.000Z"},{"id":"recv9Zk4YM6rrzCm9","fields":{},"createdTime":"2020-09-02T15:21:46.000Z"}]}';

      when(mockClient.get('https://api.airtable.com/v0/322/t1'))
          .thenAnswer((_) async => http.Response(responseString, 200));

      final client = Client(
          table: 't1', apiKey: '123', base: '322', httpClient: mockClient);

      final records = await client.records();
      expect(records['records'][0]['id'], equals('recAn1qY01DxTcfJj'));
    });
  });
}
