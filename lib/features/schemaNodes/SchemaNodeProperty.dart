import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/ChangeableProperty.dart';
import 'package:flutter_app/features/schemaNodes/JsonConvertable.dart';

abstract class SchemaNodeProperty<T>
    implements ChangeableProperty<T>, JsonConvertable {
  String name;
  T value;
  SchemaNodeProperty properties;

  SchemaNodeProperty(String name, value) {
    this.name = name;
    this.value = value;
  }

  SchemaNodeProperty copy();

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

class SchemaColorProperty extends SchemaNodeProperty<Color> {
  SchemaColorProperty(String name, Color value) : super(name, value);

  @override
  SchemaColorProperty copy() {
    return SchemaColorProperty(this.name, value);
  }
}

class SchemaRemoteProperty extends SchemaNodeProperty<SchemaNodeProperty> {
  String remoteId;

  SchemaRemoteProperty(String name, value, remoteId) : super(name, value) {
    this.remoteId = remoteId;
  }

  SchemaNodeProperty get value => value;

  @override
  SchemaRemoteProperty copy() {
    return SchemaRemoteProperty(this.name, value, remoteId);
  }
}
