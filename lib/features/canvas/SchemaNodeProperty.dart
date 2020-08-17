import 'package:flutter/material.dart';

abstract class SchemaNodeProperty {
  String name;
  String value;
  SchemaNodeProperty properties;

  SchemaNodeProperty(String name, String value) {
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

// типа Color, BackgroundColor
class SchemaSimpleProperty extends SchemaNodeProperty {
  SchemaSimpleProperty(String name, String value) : super(name, value);
}
