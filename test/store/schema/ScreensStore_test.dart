import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('createScreen()', () {
    test('it adds new screen', () {
      final newScreen = SchemaStore(components: []);
      final store = ScreensStore();

      store.createScreen(newScreen);
      expect(store.screens.length, equals(1));
    });
  });
}
