import 'package:flutter_app/features/airtable/IRemoteTable.dart';

class AirtableTable implements IRemoteTable {
  @override
  String table;
  String base;
  AirtableTable(this.table, this.base);

  @override
  Future<Map<String, dynamic>> records() async {
    return {};
  }
}
