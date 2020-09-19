import 'package:flutter/material.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/airtable/RemoteTextValue.dart';
import 'package:flutter_app/features/schemaNodes/ChangeableProperty.dart';
import 'package:flutter_app/features/schemaNodes/JsonConvertable.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

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

  StatefulWidget input(Function onChange) {
    return TextField(
      onChanged: onChange,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: this.name),
    );
  }
}

// типа Text
class SchemaStringProperty extends SchemaNodeProperty {
  SchemaStringProperty(String name, String value) : super(name, value);

  @override
  SchemaStringProperty copy() {
    return SchemaStringProperty(this.name, value);
  }
}

class SchemaIntProperty extends SchemaNodeProperty {
  SchemaIntProperty(String name, int value) : super(name, value);

  @override
  SchemaIntProperty copy() {
    return SchemaIntProperty(this.name, value);
  }
}

class SchemaDoubleProperty extends SchemaNodeProperty {
  SchemaDoubleProperty(String name, double value) : super(name, value);

  @override
  SchemaDoubleProperty copy() {
    return SchemaDoubleProperty(this.name, value);
  }

  @override
  var value;
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

class SchemaStringListProperty
    extends SchemaNodeProperty<List<SchemaStringProperty>> {
  SchemaStringListProperty(String name, List<SchemaStringProperty> value)
      : super(name, value);

  @override
  SchemaStringListProperty copy() {
    return SchemaStringListProperty(this.name, value);
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
