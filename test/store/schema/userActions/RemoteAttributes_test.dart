import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/store/userActions/RemoteAttributes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteTable extends Mock implements IRemoteTable {
  String table;
  MockRemoteTable([this.table = 'table']);

  Future<Map<String, dynamic>> records() async {
    return {
      "records": [
        {
          "id": '123',
          "fields": {"Test": "333"}
        },
        {
          "id": '444',
          "fields": {"Test22": "33", "Test": "42"}
        }
      ]
    };
  }
}

void main() {
  group('update()', () {
    test('updates records', () async {
      final client = MockRemoteTable();
      final attributes = RemoteAttributes();
      await attributes.update(client);
      final targetTable = attributes.tables[client.table];
      expect(attributes.attributes.length, equals(3));
      expect(targetTable.length, equals(2));
    });
  });
}
