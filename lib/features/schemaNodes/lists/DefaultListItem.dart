import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';

class DefaultListItem implements ListItem {
  @override
  SchemaStringProperty photo;

  @override
  SchemaStringProperty subTitle;

  @override
  SchemaStringProperty text;

  @override
  SchemaStringProperty title;

  DefaultListItem({this.title, this.subTitle, this.photo, this.text});

  @override
  Widget renderWidget() {
    return Text(
      text.value,
      style: TextStyle(fontSize: 16.0),
    );
  }
}
