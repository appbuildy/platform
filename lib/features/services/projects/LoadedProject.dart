import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/services/project_load/ComponentLoadedFromJson.dart';
import 'package:flutter_app/features/services/projects/IProjectLoad.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_app/utils/RandomKey.dart';

class LoadedProject implements IProjectLoad {
  Map<String, dynamic> jsonCanvas;
  AppThemeStore themeStore;
  BottomNavigationStore bottomNav;

  LoadedProject(
      {Map<String, dynamic> json,
      AppThemeStore themeStore,
      BottomNavigationStore bottomNav}) {
    this.jsonCanvas = json;
    this.themeStore = themeStore;
    this.bottomNav = bottomNav;
  }

  @override
  Screens load() {
    final List<SchemaStore> loadedScreens = _loadScreens();
    final store = ScreensStore(screens: loadedScreens);
    final current = CurrentScreen(loadedScreens.first);
    final screens = Screens(store, current);
    _loadTheme();
    _loadBottomNavigation();

    return screens;
  }

  void _loadBottomNavigation() {
    if (jsonCanvas['bottomNavigation'] == null) {
      return;
    }

    this.bottomNav =
        BottomNavigationStore.fromJson(jsonCanvas['bottomNavigation']);
  }

  void _loadTheme() {
    if (jsonCanvas['theme'] == null) {
      return;
    }

    themeStore?.setTheme(MyTheme.fromJson(jsonCanvas['theme']));
  }

  List<SchemaStore> _loadScreens() {
    return jsonCanvas['screens']
        .map((jsonScreen) {
          return SchemaStore(
              name: jsonScreen['name'],
              id: jsonScreen['id'] == null
                  ? null
                  : RandomKey.fromJson(jsonScreen['id']),
              backgroundColor: jsonScreen['backgroundColor'] == null
                  ? null
                  : MyThemeProp.fromJson(jsonScreen['backgroundColor']),
              detailedInfo: jsonScreen['detailedInfo'] == null
                  ? null
                  : DetailedInfo.fromJson(jsonScreen['detailedInfo']),
              bottomTabsVisible: jsonScreen['bottomTabsVisible'],
              components: _loadComponents(jsonScreen));
        })
        .toList()
        .cast<SchemaStore>();
  }

  List<SchemaNode> _loadComponents(Map<String, dynamic> screenJson) {
    if (jsonCanvas['screens'] == null ||
        screenJson == null ||
        screenJson['components'] == null) {
      return List<SchemaNode>.of([]);
    }

    return screenJson['components']
        .map((component) {
          final loadedComponent = ComponentLoadedFromJson(component).load();
          if (themeStore != null) {
            loadedComponent.themeStore = themeStore;
          }
          return loadedComponent;
        })
        .toList()
        .cast<SchemaNode>();
  }
}
