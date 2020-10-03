import 'package:flutter/cupertino.dart';

import '../SchemaNodeProperty.dart';

class SchemaListItemProperty extends SchemaNodeProperty<Map<String, ListItem>> {
  SchemaListItemProperty(String name, value) : super(name, value);

  @override
  SchemaListItemProperty copy() {
    return SchemaListItemProperty(this.name, value);
  }
}

class ListItem {
  String column;
  String data;

  ListItem({@required column, @required data}) {
    this.column = column;
    this.data = data;
  }
}
