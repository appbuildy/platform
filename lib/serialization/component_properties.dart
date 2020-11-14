import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/services/project_load/properties_loader.dart';

class ComponentProperties {
  Offset position;
  Offset size;
  Map<String, SchemaNodeProperty> properties;
  Map<String, SchemaNodeProperty> actions;
  Map<String, dynamic> jsonComponent;

  ComponentProperties(jsonComponent) {
    this.jsonComponent = jsonComponent;

    _loadPosition();
    _loadSize();
    _loadProperies();
    _loadActions();
  }

  void _loadPosition() {
    double x = jsonComponent['position']['x'].toDouble();
    double y = jsonComponent['position']['y'].toDouble();
    position = Offset(x.toDouble(), y.toDouble());
  }

  void _loadSize() {
    double x = jsonComponent['size']['x'].toDouble();
    double y = jsonComponent['size']['y'].toDouble();
    size = Offset(x.toDouble(), y.toDouble());
  }

  void _loadProperies() {
    properties = PropertiesLoader(jsonComponent).load();
  }

  void _loadActions() {
    final Map<String, SchemaNodeProperty> deserialized = {};
    jsonComponent['actions'].forEach((key, val) {
      deserialized[key] = SchemaNodeProperty.deserializeActionFromJson(val);
    });
    actions = deserialized;
  }
}
