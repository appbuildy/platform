import 'package:flutter_app/features/airtable/RemoteTextValue.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockText extends Mock implements RemoteTextValue {
  String val;
  MockText(this.val);

  @override
  Future<String> fetch() async {
    return val;
  }
}

void main() {
  group('SchemaRemoteProperty remoteValue', () {
    test('it fetches from remote', () async {
      final RemoteTextValue rText = MockText('123');
      final prop = SchemaRemoteStringProperty('Name', 'Value', rText);
      final value = await prop.remoteValue;
      expect(value, equals('123'));
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
