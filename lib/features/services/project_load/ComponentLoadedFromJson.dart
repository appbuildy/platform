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

    switch (jsonComponent['type']) {
      case 'SchemaNodeType.button':
        {
          return SchemaNodeButton(
              position: _loadPosition(),
              size: _loadSize(),
              themeStore: themeStore);
        }
        break;
    }
    return SchemaNodeButton(
        position: _loadPosition(), size: _loadSize(), themeStore: themeStore);
  }

  Offset _loadPosition() {
    double x = jsonComponent['position']['x'];
    double y = jsonComponent['position']['y'];
    return Offset(x.toDouble(), y.toDouble());
  }

  Offset _loadSize() {
    double x = jsonComponent['size']['x'];
    double y = jsonComponent['size']['y'];
    return Offset(x.toDouble(), y.toDouble());
  }

  SchemaNodeProperty _loadProperty() {
    final Map<String, SchemaNodeProperty> props = {};
  }
}
