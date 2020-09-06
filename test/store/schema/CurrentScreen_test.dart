import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('createScreen()', () {
    test('it adds new screen', () {
      final schemaStore = SchemaStore(components: []);
      final anotherScreen = SchemaStore(components: []);
      final newScreen = CurrentScreen(schemaStore);

      newScreen.select(anotherScreen);
      expect(newScreen.currentScreen, equals(anotherScreen));
    });
  });
}
