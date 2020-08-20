import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Screens screens;
  ScreensStore store;
  CurrentScreen current;
  SchemaStore schema;

  setUp(() {
    schema = SchemaStore(components: []);
    current = CurrentScreen(schema);
    store = ScreensStore(screens: [current.currentScreen]);

    screens = Screens(store, current);
  });

  test('current()', () {
    screens.create();

    expect(screens.all.screens.length, equals(2));
  });

  test('nextScreen() moves to next screen', () {
    screens.create();
    screens.nextScreen();

    expect(screens.current, equals(screens.all.screens.last));
  });
}
