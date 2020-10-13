import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/services/project_load/IComponentLoader.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class ComponentLoadedFromJson implements IComponentLoader {
  Map<String, dynamic> jsonComponent;
  ComponentLoadedFromJson(this.jsonComponent);

  @override
  SchemaNode load() {
    final themeStore = AppThemeStore();
    themeStore
        .setTheme(MyThemes.allThemes['blue']); //TODO: Загружать тему нормально

    return SchemaNodeButton(size: _loadSize(), theme: themeStore);
  }

  Offset _loadSize() {
    int x = jsonComponent['size']['x'];
    int y = jsonComponent['size']['y'];
    return Offset(x.toDouble(), y.toDouble());
  }

  SchemaNodeProperty _loadProperty() {
    final Map<String, SchemaNodeProperty> props = {};
  }
}
