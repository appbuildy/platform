import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/services/project_load/ComponentLoadedFromJson.dart';
import 'package:flutter_app/features/services/projects/IProjectLoad.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';

class LoadedProject implements IProjectLoad {
  Map<String, dynamic> jsonCanvas;
  LoadedProject(this.jsonCanvas);

  @override
  Screens load() {
    final screen = SchemaStore(name: 'Home', components: _loadComponents());
    final store = ScreensStore(screens: [screen]);
    final current = CurrentScreen(screen);
    final screens = Screens(store, current);

    return screens;
  }

  List<SchemaNode> _loadComponents() {
    return jsonCanvas['screens']
        .first['components']
        .map((component) {
          return ComponentLoadedFromJson(component).load();
        })
        .toList()
        .cast<SchemaNode>();
  }
}
