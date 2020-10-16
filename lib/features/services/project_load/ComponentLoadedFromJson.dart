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
              properties: _loadProperies(),
              themeStore: themeStore);
        }
        break;
    }
    return SchemaNodeButton(
        position: _loadPosition(), size: _loadSize(), themeStore: themeStore);
  }

  Offset _loadPosition() {
    double x = jsonComponent['position']['x'].toDouble();
    double y = jsonComponent['position']['y'].toDouble();
    return Offset(x.toDouble(), y.toDouble());
  }

  Offset _loadSize() {
    double x = jsonComponent['size']['x'].toDouble();
    double y = jsonComponent['size']['y'].toDouble();
    return Offset(x.toDouble(), y.toDouble());
  }

  Map<String, SchemaNodeProperty> _loadProperies() {
    final Map<String, SchemaNodeProperty> deserialized = {};
    jsonComponent['properties'].forEach((key, val) {
      deserialized[key] = SchemaNodeProperty.deserializeFromJson(val);
    });
    return deserialized;
  }
}
