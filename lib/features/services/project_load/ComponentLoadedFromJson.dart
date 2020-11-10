import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/services/project_load/IComponentLoader.dart';
import 'package:flutter_app/features/services/project_load/properties_loader.dart';

class ComponentLoadedFromJson implements IComponentLoader {
  Map<String, dynamic> jsonComponent;
  SchemaNodeSpawner schemaNodeSpawner;

  ComponentLoadedFromJson({
    @required this.jsonComponent,
    @required this.schemaNodeSpawner,
  });

  @override
  SchemaNode load() {
    switch (jsonComponent['type']) {
      case 'SchemaNodeType.button':
        {
          return schemaNodeSpawner.spawnSchemaNodeButton(
            position: _loadPosition(),
            size: _loadSize(),
            properties: _loadProperies(),
            actions: _loadActions(),
          );
        }

      case 'SchemaNodeType.text':
        {
          return schemaNodeSpawner.spawnSchemaNodeText(
            position: _loadPosition(),
            size: _loadSize(),
            actions: _loadActions(),
            properties: _loadProperies(),
          );
        }
        break;

      case 'SchemaNodeType.shape':
        {
          return schemaNodeSpawner.spawnSchemaNodeShape(
            position: _loadPosition(),
            size: _loadSize(),
            actions: _loadActions(),
            properties: _loadProperies(),
          );
        }
        break;

      case 'SchemaNodeType.icon':
        {
          return schemaNodeSpawner.spawnSchemaNodeIcon(
            position: _loadPosition(),
            actions: _loadActions(),
            size: _loadSize(),
            properties: _loadProperies(),
          );
        }
        break;

      case 'SchemaNodeType.list':
        {
          return schemaNodeSpawner.spawnSchemaNodeList(
            listTemplateType: ListTemplateType.cards,
            actions: _loadActions(),
            position: _loadPosition(),
            size: _loadSize(),
            properties: _loadProperies(),
          );
        }
        break;
      case 'SchemaNodeType.image':
        {
          return schemaNodeSpawner.spawnSchemaNodeImage(
              actions: _loadActions(),
              position: _loadPosition(),
              size: _loadSize(),
              properties: _loadProperies());
        }
        break;
    }
    return schemaNodeSpawner.spawnSchemaNodeButton(
      position: _loadPosition(),
      size: _loadSize(),
    );
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
