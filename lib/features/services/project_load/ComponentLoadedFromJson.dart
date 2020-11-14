import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeIcon.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/services/project_load/IComponentLoader.dart';
import 'package:flutter_app/serialization/component_properties.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class ComponentLoadedFromJson implements IComponentLoader {
  Map<String, dynamic> jsonComponent;

  ComponentLoadedFromJson(this.jsonComponent);

  @override
  SchemaNode load() {
    final themeStore = AppThemeStore();
    final componentProperties = ComponentProperties(jsonComponent);
    themeStore
        .setTheme(MyThemes.allThemes['blue']); //TODO: Загружать тему нормально

    switch (jsonComponent['type']) {
      case 'SchemaNodeType.button':
        {
          return SchemaNodeButton(
              position: componentProperties.position,
              size: componentProperties.size,
              properties: componentProperties.properties,
              actions: componentProperties.actions,
              themeStore: themeStore);
        }

      case 'SchemaNodeType.text':
        {
          return SchemaNodeText(
              position: componentProperties.position,
              size: componentProperties.size,
              properties: componentProperties.properties,
              actions: componentProperties.actions,
              themeStore: themeStore);
        }
        break;

      case 'SchemaNodeType.shape':
        {
          return SchemaNodeShape(
              position: componentProperties.position,
              size: componentProperties.size,
              properties: componentProperties.properties,
              actions: componentProperties.actions,
              themeStore: themeStore);
        }
        break;

      case 'SchemaNodeType.icon':
        {
          return SchemaNodeIcon(
              position: componentProperties.position,
              size: componentProperties.size,
              properties: componentProperties.properties,
              actions: componentProperties.actions,
              themeStore: themeStore);
        }
        break;

      case 'SchemaNodeType.list':
        {
          return SchemaNodeList(
              listTemplateType: ListTemplateType.cards,
              position: componentProperties.position,
              size: componentProperties.size,
              properties: componentProperties.properties,
              actions: componentProperties.actions,
              themeStore: themeStore);
        }
        break;
      case 'SchemaNodeType.image':
        {
          return SchemaNodeImage(
              position: componentProperties.position,
              size: componentProperties.size,
              properties: componentProperties.properties,
              actions: componentProperties.actions);
        }
        break;
    }
    return SchemaNodeButton(
        position: componentProperties.position,
        size: componentProperties.size,
        properties: componentProperties.properties,
        actions: componentProperties.actions,
        themeStore: themeStore);
  }
}
