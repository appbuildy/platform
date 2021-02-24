import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/airtable/values_cast.dart';

class ListItem {
  String column;
  String data;

  ListItem({
    @required this.column,
    @required this.data,
  });

  Map<String, String> toJson() {
    return {
      'column': this.column,
      'data': this.data,
    };
  }

  ListItem.fromJson(Map<String, dynamic> targetJson) {
    this.column = targetJson['column'];
    this.data = ValuesCast(targetJson['data']).toString();
  }
}
