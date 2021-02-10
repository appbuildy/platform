import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/services/project_load/IComponentLoader.dart';
import 'package:flutter_app/serialization/component_properties.dart';

class ComponentLoadedFromJson implements IComponentLoader {
  Map<String, dynamic> jsonComponent;
  SchemaNodeSpawner schemaNodeSpawner;

  ComponentLoadedFromJson({
    @required this.jsonComponent,
    @required this.schemaNodeSpawner,
  });

  @override
  SchemaNode load() {
    final componentProperties = ComponentProperties(jsonComponent,
        schemaNodeSpawner: schemaNodeSpawner);

    switch (jsonComponent['type']) {
      case 'SchemaNodeType.map':
        {
          return schemaNodeSpawner.spawnSchemaNodeMap(
            position: componentProperties.position,
            size: componentProperties.size,
            properties: componentProperties.properties,
            actions: componentProperties.actions,
          );
        }

      case 'SchemaNodeType.button':
        {
          return schemaNodeSpawner.spawnSchemaNodeButton(
            position: componentProperties.position,
            size: componentProperties.size,
            properties: componentProperties.properties,
            actions: componentProperties.actions,
          );
        }

      case 'SchemaNodeType.text':
        {
          return schemaNodeSpawner.spawnSchemaNodeText(
            position: componentProperties.position,
            size: componentProperties.size,
            properties: componentProperties.properties,
            actions: componentProperties.actions,
          );
        }
        break;

      case 'SchemaNodeType.shape':
        {
          return schemaNodeSpawner.spawnSchemaNodeShape(
            position: componentProperties.position,
            size: componentProperties.size,
            properties: componentProperties.properties,
            actions: componentProperties.actions,
          );
        }
        break;

      case 'SchemaNodeType.icon':
        {
          return schemaNodeSpawner.spawnSchemaNodeIcon(
            position: componentProperties.position,
            size: componentProperties.size,
            properties: componentProperties.properties,
            actions: componentProperties.actions,
          );
        }
        break;

      case 'SchemaNodeType.list':
        {
          return schemaNodeSpawner.spawnSchemaNodeList(
            listTemplateType: ListTemplateType.cards,
            position: componentProperties.position,
            size: componentProperties.size,
            properties: componentProperties.properties,
            actions: componentProperties.actions,
          );
        }
        break;
      case 'SchemaNodeType.image':
        {
          return schemaNodeSpawner.spawnSchemaNodeImage(
            position: componentProperties.position,
            size: componentProperties.size,
            properties: componentProperties.properties,
            actions: componentProperties.actions,
          );
        }
        break;
      case 'SchemaNodeType.form':
        {
          return schemaNodeSpawner.spawnSchemaNodeForm(
            position: componentProperties.position,
            size: componentProperties.size,
            properties: componentProperties.properties,
            actions: componentProperties.actions,
          );
        }
        break;
    }
    return schemaNodeSpawner.spawnSchemaNodeButton(
      position: componentProperties.position,
      size: componentProperties.size,
      properties: componentProperties.properties,
      actions: componentProperties.actions,
    );
  }
}
