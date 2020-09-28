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

class SchemaFontWeightProperty extends SchemaNodeProperty {
  SchemaFontWeightProperty(String name, FontWeight value) : super(name, value);

  @override
  SchemaFontWeightProperty copy() {
    return SchemaFontWeightProperty(this.name, value);
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
o}

class SchemaStringListProperty
    extends SchemaNodeProperty<Map<String, SchemaStringProperty>> {
  SchemaStringListProperty(String name, Map<String, SchemaStringProperty> value)
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
