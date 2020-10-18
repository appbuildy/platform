import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'dart:convert';

import 'package:flutter_app/utils/RandomKey.dart';

class DetailedInfo {
  String tableName;
  RandomKey screenId;
  Map<String, ListItem> rowData;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> rowDataMap = {};

    return {
      'tableName': tableName,
      'screenId': screenId.toJson(),
      'rowData': rowDataMap
    };
  }

  DetailedInfo.fromJson(Map<String, dynamic> jsonVal) {
    this.tableName = jsonVal['tableName'];
    this.screenId = RandomKey.fromJson(jsonVal['screenId']);
  }

  DetailedInfo(
      {@required String tableName,
      @required RandomKey screenId,
      @required Map<String, ListItem> rowData}) {
    this.tableName = tableName;
    this.screenId = screenId;
    this.rowData = rowData;
  }
}
