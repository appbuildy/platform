import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';

export 'SchemaNodeButton.dart';
export 'SchemaNodeImage.dart';
export 'SchemaNodeProperty.dart';
export 'SchemaNodeShape.dart';
export 'SchemaNodeText.dart';

enum SchemaNodeType { button, text, shape, image, list }

abstract class SchemaNode {
  UniqueKey id;
  SchemaNodeType type;
  Offset position;
  AppThemeStore theme;
  Offset size;
  Map<String, SchemaNodeProperty> properties;
  Map<String, SchemaNodeProperty> changeableProperties;
  Map<String, SchemaNodeProperty> actions;

  SchemaNode copy({
    Offset position,
    Offset size,
    UniqueKey id,
    bool saveProperties,
  });

  Map<String, dynamic> toJson() => {
        'position': {'x': position.dx, 'y': position.dy},
        'size': {'x': size.dx, 'y': size.dy},
        'properties': _jsonProperties(),
        'actions': _jsonActions(),
        'type': SchemaNodeType.button
      };
  Widget toWidget();
  Widget toEditProps(UserActions userActions);

  Map<String, dynamic> _jsonActions() {
    final map = {};
    actions.forEach((k, v) => map[k] = v.toJson());
    return map;
  }

  Map<String, dynamic> _jsonProperties() {
    final map = {};
    properties.forEach((k, v) => map[k] = v.toJson());
    return map;
  }
}
