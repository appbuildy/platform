import 'package:flutter/material.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/airtable/RemoteTextValue.dart';
import 'package:flutter_app/features/schemaNodes/ChangeableProperty.dart';
import 'package:flutter_app/features/schemaNodes/JsonConvertable.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

import 'lists/ListItem.dart';

abstract class SchemaNodeProperty<T>
    implements ChangeableProperty<T>, JsonConvertable {
  String name;
  T _value;
  IRemoteAttribute remoteAttr;
  SchemaNodeProperty properties;

  SchemaNodeProperty(String name, value, [IRemoteAttribute remoteAttribute]) {
    this.name = name;
    this._value = value;
    this.remoteAttr = remoteAttribute;
  }

  SchemaNodeProperty copy();
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

  SchemaNodeProperty.fromJson(Map<String, dynamic> targetJson) {
    this.name = 'Text';
  }

  StatefulWidget input(Function onChange) {
    return TextField(
      onChanged: onChange,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: this.name),
    );
  }
}

class SchemaBoolProperty extends SchemaNodeProperty {
  SchemaBoolProperty(String name, bool value) : super(name, value);

  @override
  SchemaBoolProperty copy() {
    return SchemaBoolProperty(this.name, value);
  }
}

class SchemaIntProperty extends SchemaNodeProperty {
  SchemaIntProperty(String name, int value) : super(name, value);

  @override
  SchemaIntProperty copy() {
    return SchemaIntProperty(this.name, value);
  }
}

class SchemaTextAlignProperty extends SchemaNodeProperty {
  SchemaTextAlignProperty(String name, TextAlign value) : super(name, value);

  @override
  SchemaTextAlignProperty copy() {
    return SchemaTextAlignProperty(this.name, value);
  }
}

class SchemaMainAlignmentProperty extends SchemaNodeProperty {
  SchemaMainAlignmentProperty(String name, MainAxisAlignment value)
      : super(name, value);

  @override
  SchemaMainAlignmentProperty copy() {
    return SchemaMainAlignmentProperty(this.name, value);
  }
}

class SchemaCrossAlignmentProperty extends SchemaNodeProperty {
  SchemaCrossAlignmentProperty(String name, CrossAxisAlignment value)
      : super(name, value);

  @override
  SchemaCrossAlignmentProperty copy() {
    return SchemaCrossAlignmentProperty(this.name, value);
  }
}

class SchemaIconProperty extends SchemaNodeProperty {
  SchemaIconProperty(String name, IconData value) : super(name, value);

  @override
  SchemaIconProperty copy() {
    return SchemaIconProperty(this.name, value);
  }
}

class SchemaDoubleProperty extends SchemaNodeProperty {
  SchemaDoubleProperty(String name, double value) : super(name, value);

  @override
  SchemaDoubleProperty copy() {
    return SchemaDoubleProperty(this.name, value);
  }
}

class SchemaColorProperty extends SchemaNodeProperty<Color> {
  SchemaColorProperty(String name, Color value) : super(name, value);

  @override
  SchemaColorProperty copy() {
    return SchemaColorProperty(this.name, value);
  }
}

class SchemaMyThemePropProperty extends SchemaNodeProperty<MyThemeProp> {
  SchemaMyThemePropProperty(String name, MyThemeProp value)
      : super(name, value);

  @override
  SchemaMyThemePropProperty copy() {
    return SchemaMyThemePropProperty(this.name, value);
  }
}

class ListTemplateProperty extends SchemaNodeProperty<ListTemplate> {
  ListTemplateProperty(String name, ListTemplate value) : super(name, value);

  @override
  ListTemplateProperty copy() {
    return ListTemplateProperty(this.name, value);
  }
}

class SchemaStringListProperty
    extends SchemaNodeProperty<Map<String, SchemaListItemProperty>> {
  static Future<SchemaStringListProperty> fromRemoteTable(
      IRemoteTable remoteTable) async {
    final records = await remoteTable.records();
    final result = SchemaStringListProperty(
        'Items', Map<String, SchemaListItemProperty>());

    records['records'].forEach((record) {
      print(record);
      final mapProps = Map<String, ListItem>();
      final prop = SchemaListItemProperty(record['id'], mapProps);
      record['fields'].forEach((key, value) {
        mapProps[key] = ListItem(column: key, data: value);
      });
      result.value[record['id']] = prop;
    });
    return result;
  }

  factory SchemaStringListProperty.sample() {
    return SchemaStringListProperty('Items', {
      // пример дата айтемов-row с сгенеренными
      'mac': SchemaListItemProperty('mac', {
        'restaurant_name':
            ListItem(column: 'restaurant_name', data: 'McDonalds'),
        'restaurant_rate':
            ListItem(column: 'restaurant_rate', data: 'Fast Food'),
        'restaurant_url': ListItem(
            column: 'restaurant_url',
            data:
                'https://images.unsplash.com/photo-1552895638-f7fe08d2f7d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80'),
      }),
      'bk': SchemaListItemProperty('mac', {
        'restaurant_name':
            ListItem(column: 'restaurant_name', data: 'Burger King'),
        'restaurant_rate':
            ListItem(column: 'restaurant_rate', data: 'Fast Food'),
        'restaurant_url': ListItem(
            column: 'restaurant_url',
            data:
                'https://images.unsplash.com/photo-1528669826296-dbd6f641707d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80'),
      }),
      'lucky': SchemaListItemProperty('lucky', {
        'restaurant_name':
            ListItem(column: 'restaurant_name', data: 'Lucky In The Kai'),
        'restaurant_rate':
            ListItem(column: 'restaurant_rate', data: 'Elite Restaurant'),
        'restaurant_url': ListItem(
            column: 'restaurant_url',
            data:
                'https://images.unsplash.com/photo-1579065693224-0a3abed6a058?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=256&q=80'),
      }),
    });
  }

  SchemaStringListProperty(
      String name, Map<String, SchemaListItemProperty> value)
      : super(name, value);

  @override
  SchemaStringListProperty copy() {
    return SchemaStringListProperty(this.name, this.value);
  }
}

class SchemaRemoteStringProperty extends SchemaNodeProperty<String> {
  RemoteTextValue remoteWrapper;

  SchemaRemoteStringProperty(String name, value, remoteWrapper)
      : super(name, value) {
    this.remoteWrapper = remoteWrapper;
  }

  Future<String> get remoteValue async => await remoteWrapper.fetch();

  @override
  SchemaRemoteStringProperty copy() {
    return SchemaRemoteStringProperty(this.name, value, remoteWrapper);
  }

  @override
  String value;
}
