import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/schemaNodes/RemoteSchemaPropertiesBinding.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteTable extends Mock implements IRemoteTable {
  Future<Map<String, dynamic>> records() async {
    return {
      "records": [
        {
          "id": '123',
          "fields": {"Test": "333"}
        },
        {
          "id": '444',
          "fields": {"Test22": "33"}
        }
      ]
    };
  }
}

void main() {
  test('update() fetches remote data using table', () async {
    final id = '123';
    final fieldName = 'Test';
    final prop = SchemaStringProperty('ButtonText', '1');
    final mockedTable = MockRemoteTable();
    final remoteProps = RemoteSchemaPropertiesBinding(mockedTable);
    remoteProps.addMapping('123', 'Test', prop);

    await remoteProps.update();

    expect(prop.value, equals('333'));
  });
}
