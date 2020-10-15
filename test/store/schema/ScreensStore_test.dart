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

    test('it replaces screen with same name', () {
      final newScreen = SchemaStore(components: [], name: 'h o m e');
      final toReplaceScreen = SchemaStore(components: [], name: 'h o m e');
      final store = ScreensStore();

      store.createScreen(newScreen);
      store.createScreen(toReplaceScreen);
      expect(store.screens.length, equals(1));
    });
  });
}
