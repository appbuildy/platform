import 'package:flutter_app/features/airtable/airtable_client.dart';
import 'package:flutter_app/features/airtable/RemoteTextValue.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements AirtableClient {
  Future<Map<String, dynamic>> record(String id) async {
    return {
      "fields": {'Button': 322}
    };
  }
}

void main() {
  test('fetch() fetches remote data using airtable client', () async {
    final client = MockClient();
    final remoteId = '123';
    final fieldName = 'Button';

    final remoteValue = RemoteTextValue(client, remoteId, fieldName);
    final val = await remoteValue.fetch();
    expect(val, equals('322'));
  });
}
