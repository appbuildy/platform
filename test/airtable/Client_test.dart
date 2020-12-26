import 'package:flutter_app/features/airtable/airtable_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class MockedClient extends MockClient {
  MockedClient(fn) : super(fn);
}

void main() {
  group('record', () {
    test('requests record', () async {
      final responseBody =
          '{ "id": "recAn1qY01DxTcfJj", "fields": { "Name": "Test", "Button": "422" }, "createdTime": "2020-09-02T15:21:46.000Z" }';
      final mockClient = MockedClient((request) async {
        return http.Response(responseBody, 200, request: request);
      });

      final client = AirtableClient(
          table: 't1', apiKey: '123', base: '322', httpClient: mockClient);
      final record = await client.record('1');
      expect(record['id'], equals('recAn1qY01DxTcfJj'));
    });
  });
  group('records()', () {
    test('requests records', () async {
      final responseString =
          '{"records":[{"id":"recAn1qY01DxTcfJj","fields":{"Button":"422","Name":"Test"},"createdTime":"2020-09-02T15:21:46.000Z"},{"id":"recN1pVMNH0S0QulX","fields":{},"createdTime":"2020-09-02T15:21:46.000Z"},{"id":"recv9Zk4YM6rrzCm9","fields":{},"createdTime":"2020-09-02T15:21:46.000Z"}]}';
      final mockClient = MockedClient((request) async {
        return http.Response(responseString, 200, request: request);
      });

      final client = AirtableClient(
          table: 't1', apiKey: '123', base: '322', httpClient: mockClient);

      final records = await client.records();
      expect(records['records'][0]['id'], equals('recAn1qY01DxTcfJj'));
    });
  });
}
