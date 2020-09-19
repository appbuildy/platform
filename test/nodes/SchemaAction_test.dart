import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('copy()', () {
    test('produces new instance with given offset', () {
      final screen2Name = 'screen2';
      SchemaStore screen1 = SchemaStore(name: 'screen1', components: []);
      SchemaStore screen2 = SchemaStore(name: screen2Name, components: []);

      Screens screens = Screens(
          ScreensStore(screens: [screen1, screen2]), CurrentScreen(screen1));

      final actions = UserActions(screens: screens);
      final Functionable chgScren = GoToScreenAction('Tap', screen2.id);

      final changeScreenFn = chgScren.toFunction(actions);

      changeScreenFn();

      expect(screens.current, equals(screen2));
    });
  });
}
