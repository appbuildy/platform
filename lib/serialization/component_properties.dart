import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app_skeleton/data_layer/data_from_detailed_info.dart';
import 'package:flutter_app/app_skeleton/data_layer/detailed_info_key.dart';
import 'package:flutter_app/app_skeleton/data_layer/i_element_data.dart';
import 'package:flutter_app/app_skeleton/loading/action_load_from_json.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/app_skeleton/entities/action.dart'
    as skeleton_action;
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_app/features/services/project_load/properties_loader.dart';

class ComponentProperties {
  Offset position;
  Offset size;
  String propertyName;
  Map<String, SchemaNodeProperty> properties;
  Map<String, SchemaNodeProperty> actions;
  Map<String, skeleton_action.Action> previewActions;
  Map<String, dynamic> jsonComponent;
  IElementData elementData;

  ComponentProperties(jsonComponent,
      {IElementData elementData, SchemaNodeSpawner schemaNodeSpawner}) {
    this.jsonComponent = jsonComponent;
    this.elementData = elementData;

    _loadPosition();
    _loadSize();
    _loadProperies(schemaNodeSpawner);
    _loadActions();
    _loadPreviewActions();
    _loadPropertyFromDataSource();
  }

  void _loadPropertyFromDataSource() {
    propertyName = properties["LoadedPropertyName"]?.value;
    if (propertyName == null) {
      return;
    }

    var prop = elementData?.getFor(DetailedInfoKey(
        propertyClass: 'SchemaStringProperty',
        loadedPropertyName: propertyName,
        rowDataKey: properties['Column']?.value));

    if (prop != null) {
      var info = elementData as DataFromDetailedInfo;
      info.detailedInfo.rowData.values.forEach((rd) => print(rd.toJson()));
      print("PROP: $propertyName ${prop.value}");
      properties[prop.name] = prop;
    }
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

  void _loadProperies(SchemaNodeSpawner schemaNodeSpawner) {
    properties = PropertiesLoader(jsonComponent).load(schemaNodeSpawner);
  }

  void _loadPreviewActions() {
    final Map<String, skeleton_action.Action> deserialized = {};
    jsonComponent['actions'].forEach((key, val) {
      deserialized[key] = ActionLoadFromJson({key: val}).load();
    });
    previewActions = deserialized;
  }

  void _loadActions() {
    final Map<String, SchemaNodeProperty> deserialized = {};
    jsonComponent['actions'].forEach((key, val) {
      var loadedAction = SchemaNodeProperty.deserializeActionFromJson(val);

      if (elementData != null) {
        var data = (elementData as DataFromDetailedInfo);
        var dataFromProvider = data.getString(val['column']);
        loadedAction.value = dataFromProvider ?? loadedAction.value;
      }

      deserialized[key] = loadedAction;
    });
    actions = deserialized;
  }
}
