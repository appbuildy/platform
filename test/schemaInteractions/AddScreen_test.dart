import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AddScreen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('execute() creates new screen', () {
    final ScreensStore screensStore = ScreensStore(screens: []);
    const String name = 'myAwesomeScreen';
    final BaseAction action = AddScreen(name, screensStore);
    action.execute();

    expect(screensStore.screens.length, equals(1));
    expect(screensStore.screens.last.name, equals(name));
  });
}
