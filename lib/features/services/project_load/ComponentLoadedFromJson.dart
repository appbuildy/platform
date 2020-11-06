import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeIcon.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/services/project_load/IComponentLoader.dart';
import 'package:flutter_app/features/services/project_load/properties_loader.dart';
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
              actions: _loadActions(),
              themeStore: themeStore);
        }

      case 'SchemaNodeType.text':
        {
          return SchemaNodeText(
              position: _loadPosition(),
              size: _loadSize(),
              actions: _loadActions(),
              properties: _loadProperies(),
              themeStore: themeStore);
        }
        break;

      case 'SchemaNodeType.shape':
        {
          return SchemaNodeShape(
              position: _loadPosition(),
              size: _loadSize(),
              actions: _loadActions(),
              properties: _loadProperies(),
              themeStore: themeStore);
        }
        break;

      case 'SchemaNodeType.icon':
        {
          return SchemaNodeIcon(
              position: _loadPosition(),
              actions: _loadActions(),
              size: _loadSize(),
              properties: _loadProperies(),
              themeStore: themeStore);
        }
        break;

      case 'SchemaNodeType.list':
        {
          return SchemaNodeList(
              listTemplateType: ListTemplateType.cards,
              actions: _loadActions(),
              position: _loadPosition(),
              size: _loadSize(),
              properties: _loadProperies(),
              themeStore: themeStore);
        }
        break;
      case 'SchemaNodeType.image':
        {
          return SchemaNodeImage(
              actions: _loadActions(),
              position: _loadPosition(),
              size: _loadSize(),
              properties: _loadProperies());
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
    return PropertiesLoader(jsonComponent).load();
  }

  Map<String, SchemaNodeProperty> _loadActions() {
    final Map<String, SchemaNodeProperty> deserialized = {};
    jsonComponent['actions'].forEach((key, val) {
      deserialized[key] = SchemaNodeProperty.deserializeActionFromJson(val);
    });
    return deserialized;
  }
}
