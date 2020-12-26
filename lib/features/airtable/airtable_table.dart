import 'package:flutter_app/features/airtable/IRemoteTable.dart';

import 'airtable_client.dart';

class AirtableTable implements IRemoteTable {
  @override
  String table;
  String base;
  AirtableTable(this.table, this.base);

  @override
  Future<Map<String, dynamic>> records() async {
    return await AirtableClient.defaultClient(table: table, base: base)
        .records();
  }
}
