import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';

class DetailedInfo {
  String tableName;
  UniqueKey screenId;
  Map<String, ListItem> rowData;

  DetailedInfo(
      {@required String tableName,
      @required UniqueKey screenId,
      @required Map<String, ListItem> rowData}) {
    this.tableName = tableName;
    this.screenId = screenId;
    this.rowData = rowData;
  }
}
