import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';

abstract class ListItem {
  SchemaStringProperty title;
  SchemaStringProperty subTitle;
  SchemaStringProperty photo;
  SchemaStringProperty text;
  ListItem({this.title, this.subTitle, this.photo, this.text});

  Widget renderWidget();
}
