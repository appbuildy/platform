import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeIcon.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

import 'SchemaNode.dart';
import 'lists/ListTemplates/ListTemplate.dart';

class SchemaNodeSpawner {
  UserActions userActions;

  SchemaNodeSpawner({
    @required this.userActions,
  });

  SchemaNodeButton spawnSchemaNodeButton({
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
    String text,
  }) {
    return SchemaNodeButton(
      parent: this,
      position: position,
      size: size,
      properties: properties,
      actions: actions,
      text: text,
      id: id,
    );
  }

  SchemaNodeIcon spawnSchemaNodeIcon({
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    GoToScreenAction tapAction,
    IconData icon,
    Map<String, SchemaNodeProperty> actions,
    int iconSize,
  }) {
    return SchemaNodeIcon(
      parent: this,
      id: id,
      position: position,
      size: size,
      properties: properties,
      tapAction: tapAction,
      icon: icon,
      actions: actions,
      iconSize: iconSize,
    );
  }

  SchemaNodeList spawnSchemaNodeList({
    @required ListTemplateType listTemplateType,
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
  }) {
    return SchemaNodeList(
      parent: this,
      listTemplateType: listTemplateType,
      id: id,
      position: position,
      size: size,
      properties: properties,
      actions: actions,
    );
  }

  SchemaNodeShape spawnSchemaNodeShape({
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
  }) {
    return SchemaNodeShape(
      parent: this,
      position: position,
      size: size,
      properties: properties,
      actions: actions,
    );
  }

  SchemaNodeText spawnSchemaNodeText({
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
    String column,
    String text,
    MyThemeProp color,
    int fontSize,
    FontWeight fontWeight,
  }) {
    return SchemaNodeText(
      parent: this,
      id: id,
      position: position,
      size: size,
      properties: properties,
      actions: actions,
      column: column,
      text: text,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  SchemaNodeImage spawnSchemaNodeImage({
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    String column,
    Map<String, SchemaNodeProperty> actions,
    String url,
  }) {
    return SchemaNodeImage(
      parent: this,
      id: id,
      position: position,
      size: size,
      properties: properties,
      actions: actions,
      column: column,
      url: url,
    );
  }
}