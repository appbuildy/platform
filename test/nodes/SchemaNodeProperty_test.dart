import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteTextValue.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteTable extends Mock implements IRemoteTable {
  Future<Map<String, dynamic>> records() async {
    return {
      "records": [
        {
          "id": '123',
          "fields": {"Test": "333", "Hrantsov": "Kalyan"}
        },
        {
          "id": '444',
          "fields": {"Test22": "33", "Hrantsov": "Kalyan", "Rocketbank": "322"}
        }
      ]
    };
  }
}

class MockText extends Mock implements RemoteTextValue {
  String val;
  MockText(this.val);

  @override
  Future<String> fetch() async {
    return val;
  }
}

void main() {
  group('.fromJson', () {
    test('with button', () {
      final Map<String, dynamic> targetJson = {
        'propertyClass': 'SchemaStringProperty',
        'name': 'Text',
        'value': 'Random'
      };

      final element = SchemaNodeProperty.deserializeFromJson(targetJson);
      expect(element, isA<SchemaStringProperty>());
    });
  });

  group('SchemaStringListProperty', () {
    test('fromRemoteTable', () async {
      final SchemaStringListProperty list =
          await SchemaStringListProperty.fromRemoteTable(MockRemoteTable());
      expect(list.value['123'].value['Test'].data, equals('333'));
    });
  });

  group('copy()', () {
    test('performs deep copy', () {
      final textProp = SchemaStringProperty('Name', 'Value');

      expect(textProp.copy().value, equals(textProp.value));

      expect(textProp, isNot(equals(textProp.copy())));
    });
  });
}
