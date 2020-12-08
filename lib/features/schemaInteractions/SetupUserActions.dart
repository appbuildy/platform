import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_app/features/layout/MAIN_UNIQUE_KEY.dart';

import 'Screens.dart';

UserAction setupUserActions() {
  final SchemaStore schemaStore =
      SchemaStore(name: 'Home', components: [], id: MAIN_UNIQUE_KEY);

  final CurrentScreen currentScreen = CurrentScreen(schemaStore);
  final ScreensStore screensStore = ScreensStore();
  screensStore.createScreen(schemaStore);
  final screens = Screens(screensStore, currentScreen);

  final BottomNavigationStore bottomNavigationStore = BottomNavigationStore();

  final AppThemeStore themeStore = AppThemeStore();

  final CurrentUserStore currentUserStore = CurrentUserStore();

  final userActions = UserAction(
      currentUserStore: currentUserStore,
      screens: screens,
      bottomNavigationStore: bottomNavigationStore,
      themeStore: themeStore);

  userActions.setTheme(MyThemes.allThemes['blue']);

  return userActions;
}
