import 'package:flutter_app/features/schemaInteractions/SetupUserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/utils/SchemaConverter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toJson()', () {
    test('it creates JSON', () {
      final schemaStore = SchemaStore(components: []);
      final anotherScreen = SchemaStore(components: []);
      final ScreensStore screens =
          ScreensStore(screens: [schemaStore, anotherScreen]);

      SchemaNodeSpawner nodeSpawner = SchemaNodeSpawner(userActions: setupUserActions());

      final SchemaNodeButton btn =
          nodeSpawner.spawnSchemaNodeButton(position: Offset(2222, 2), size: Offset(22, 33));
      schemaStore.add(btn);
      final SchemaConverter converter = SchemaConverter(
          screens: screens,
          theme: MyThemes.allThemes['blue'],
          bottomNavigationStore: BottomNavigationStore());

      final json = converter.toJson();
      expect(json['canvas'], isNotNull);
      final screensJson = json['canvas']['screens'];
      final component = screensJson[0]['components'][0];

      expect(component['position']['x'], equals(btn.position.dx));
    });
  });
}
