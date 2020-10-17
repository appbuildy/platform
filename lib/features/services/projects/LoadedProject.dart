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
    final screen = SchemaStore(name: 'Home', components: _loadComponents());
    final store = ScreensStore(screens: [screen]);
    final current = CurrentScreen(screen);
    final screens = Screens(store, current);
    _loadTheme();

    return screens;
  }

  void _loadTheme() {
    print(jsonCanvas['theme']);
    if (jsonCanvas['theme'] == null) {
      return;
    }

    themeStore?.setTheme(MyTheme.fromJson(jsonCanvas['theme']));
  }

  List<SchemaNode> _loadComponents() {
    if (jsonCanvas['screens'] == null) {
      return List<SchemaNode>.of([]);
    }

    return jsonCanvas['screens']
        .first['components']
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
