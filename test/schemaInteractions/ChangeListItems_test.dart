import 'package:flutter_app/features/schemaInteractions/ChangeListItems.dart';
import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it changes lists', () {
    final themeStore = AppThemeStore();
    themeStore.setTheme(MyThemes.lightBlue);
    final list = SchemaNodeList(theme: themeStore);
    final screen2Name = 'screen2';
    SchemaStore screen1 = SchemaStore(name: 'screen1', components: [list]);
    SchemaStore screen2 = SchemaStore(name: screen2Name, components: []);

    Screens screens = Screens(
        ScreensStore(screens: [screen1, screen2]), CurrentScreen(screen1));
    final userActions = UserActions(screens: screens);

    userActions.selectNodeForEdit(list);

    final ChangeListItems changeItems = ChangeListItems(userActions);
    changeItems.change(
        list: list.properties['Items'], itemKey: 'item1', newValue: '444');
    expect(list.properties['Items'].value['item1'].value, equals('444'));
  });
}
