import 'package:flutter/material.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/schemaNodes/ChangeableProperty.dart';
import 'package:flutter_app/features/schemaNodes/JsonConvertable.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaColorProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaCrossAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaFontWeightProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIconProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListTemplateProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMainAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaTextAlignProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';

import 'SchemaNodeSpawner.dart';
import 'my_do_nothing_action.dart';
import 'properties/SchemaStringProperty.dart';

class SchemaNodeProperty<T> implements ChangeableProperty<T>, JsonConvertable {
  String name;
  T _value;
  IRemoteAttribute remoteAttr;
  SchemaNodeProperty properties;

  SchemaNodeProperty(String name, value, [IRemoteAttribute remoteAttribute]) {
    this.name = name;
    this._value = value;
    this.remoteAttr = remoteAttribute;
  }

  SchemaNodeProperty copy() {
    return null;
  }

  Future<T> get remoteValue async => value;
  set remoteAttribute(IRemoteAttribute attribute) => remoteAttr = attribute;
  set value(T val) => _value = val;
  T get value => remoteAttr != null && remoteAttr.value != null
      ? remoteAttr.value
      : _value;

  @override
  Map<String, dynamic> toJson() {
    return {'name': value.toString()};
  }

  static SchemaNodeProperty deserializeActionFromJson(
      Map<String, dynamic> targetJson) {
    try {
      switch (targetJson['propertyClass']) {
        case 'GoToScreenAction':
          {
            return GoToScreenAction.fromJson(targetJson);
          }
          break;
        default:
          {
            print('Failed to deserialize action: no deserializer');
            return MyDoNothingAction();
          }
      }
    } catch (e) {
      print('Failed to deserialize action with exception: $e');
      return MyDoNothingAction();
    }
  }

  static SchemaNodeProperty deserializeFromJson(
      Map<String, dynamic> targetJson, SchemaNodeSpawner schemaNodeSpawner) {
    try {
      switch (targetJson['propertyClass']) {
        case 'SchemaFontWeightProperty':
          {
            return SchemaFontWeightProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaDoubleProperty':
          {
            return SchemaDoubleProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaIntProperty':
          {
            return SchemaIntProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaBoolProperty':
          {
            return SchemaBoolProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaColorProperty':
          {
            return SchemaColorProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaMyThemePropProperty':
          {
            return SchemaMyThemePropProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaIconProperty':
          {
            return SchemaIconProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaCrossAlignmentProperty':
          {
            return SchemaCrossAlignmentProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaMainAlignmentProperty':
          {
            return SchemaMainAlignmentProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaStringProperty':
          {
            return SchemaStringProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaListTemplateProperty':
          {
            return SchemaListTemplateProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaListItemsProperty':
          {
            return SchemaListItemsProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaTextAlignProperty':
          {
            return SchemaTextAlignProperty.fromJson(targetJson);
          }
          break;
        case 'SchemaStringListProperty':
          {
            return SchemaStringListProperty.fromJson(targetJson);
          }
          break;
        case 'ListElementsProperty':
          {
            return SchemaListElementsProperty.fromJson(targetJson, schemaNodeSpawner);
          }
          break;
        case 'SchemaListTemplateProperty':
          {
            return SchemaListTemplateProperty.fromJson(targetJson);
          }
          break;
        default:
          {
            print("No .fromJson for $targetJson");
          }
      }
    } catch (e) {
      print("Failed to deserialize $targetJson");
      throw (e);
    }
    return null;
  }

  SchemaNodeProperty.fromJson(Map<String, dynamic> targetJson) {
    this.name = 'name';
  }

  StatefulWidget input(Function onChange) {
    return TextField(
      onChanged: onChange,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: this.name),
    );
  }
}
