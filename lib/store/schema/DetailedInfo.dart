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
    rowData.forEach((key, val) {
      rowDataMap[key] = val.toJson();
    });

    return {
      'tableName': tableName,
      'screenId': screenId.toJson(),
      'rowData': rowDataMap
    };
  }

  DetailedInfo.fromJson(Map<String, dynamic> jsonVal) {
    final Map<String, ListItem> deserializedRowData = {};

    jsonVal['rowData'].forEach((key, value) {
      deserializedRowData[key] = ListItem.fromJson(value);
    });

    this.tableName = jsonVal['tableName'];
    this.screenId = RandomKey.fromJson(jsonVal['screenId']);
    this.rowData = deserializedRowData;
  }

  DetailedInfo(
      {@required String tableName,
      @required RandomKey screenId,
      @required Map<String, ListItem> rowData}) {
    rowData.values.forEach((val) {
      print(val.toJson());
    });
    this.tableName = tableName;
    this.screenId = screenId;
    this.rowData = rowData;
  }
}
