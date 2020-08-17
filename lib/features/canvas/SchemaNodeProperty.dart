import 'package:flutter/material.dart';

abstract class SchemaNodeProperty {
  String name;
  String value;

  SchemaNodeProperty(String name, String value) {
    name = name;
    value = value;
  }

  StatefulWidget input() {
    return TextField(
      decoration:
          InputDecoration(border: InputBorder.none, hintText: this.name),
    );
  }
}

// типа Color, BackgroundColor
class SchemaSimpleProperty extends SchemaNodeProperty {
  SchemaSimpleProperty(String name, String value) : super(name, value);
}
