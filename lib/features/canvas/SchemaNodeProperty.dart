import 'package:flutter/material.dart';

abstract class SchemaNodeProperty<T> {
  String name;
  T value;
  SchemaNodeProperty properties;

  SchemaNodeProperty(String name, value) {
    name = name;
    value = value;
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
class SchemaSimpleProperty extends SchemaNodeProperty<String> {
  SchemaSimpleProperty(String name, String value) : super(name, value);
}

class SchemaColorProperty extends SchemaNodeProperty<Color> {
  SchemaColorProperty(String name, Color value) : super(name, value);
}
