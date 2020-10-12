import 'package:flutter/cupertino.dart';

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
    this.data = targetJson['data'];
  }
}
