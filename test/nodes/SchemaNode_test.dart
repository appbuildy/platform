import 'package:flutter_app/features/schemaInteractions/SetupUserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('copy()', () {
    test('produces new instance with given offset', () {
      SchemaNodeSpawner nodeSpawner = SchemaNodeSpawner(userActions: setupUserActions());

      final SchemaNodeButton btn = nodeSpawner.spawnSchemaNodeButton(position: Offset(1, 2));
      expect(btn.copy(position: Offset(1, 3)), isNotNull);
    });
  });
}
