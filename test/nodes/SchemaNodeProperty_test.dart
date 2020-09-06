import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SchemaRemoteProperty remoteValue', () {
    test('it fetches from remote', () {});
  });

  group('copy()', () {
    test('performs deep copy', () {
      final textProp = SchemaStringProperty('Name', 'Value');

      expect(textProp.copy().value, equals(textProp.value));

      expect(textProp, isNot(equals(textProp.copy())));
    });
  });
}
