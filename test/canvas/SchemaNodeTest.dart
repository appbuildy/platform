import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('copy()', () {
    test('produces new instance with given offset', () {
      final SchemaNodeButton btn = SchemaNodeButton(position: Offset(1, 2));
      expect(btn.copy(position: Offset(1, 3)), isNotNull);
    });
  });
}
