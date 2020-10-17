import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/services/project_load/ComponentLoadedFromJson.dart';
import 'package:flutter_app/features/services/projects/IProjectLoad.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';

class LoadedProject implements IProjectLoad {
  Map<String, dynamic> jsonCanvas;
  AppThemeStore themeStore;

  LoadedProject({Map<String, dynamic> json, AppThemeStore themeStore}) {
    this.jsonCanvas = json;
    this.themeStore = themeStore;
  }

  @override
  Screens load() {
    final List<SchemaStore> loadedScreens = _loadScreens();
    final store = ScreensStore(screens: loadedScreens);
    final current = CurrentScreen(loadedScreens.first);
    final screens = Screens(store, current);
    _loadTheme();

    return screens;
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
              name: 'Home', components: _loadComponents(jsonScreen));
        })
        .toList()
        .cast<SchemaStore>();
  }

  List<SchemaNode> _loadComponents(Map<String, dynamic> screenJson) {
    if (jsonCanvas['screens'] == null) {
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
