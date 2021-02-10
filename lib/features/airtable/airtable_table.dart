import 'package:flutter_app/features/airtable/IRemoteTable.dart';

import 'Client.dart';

class AirtableTable implements IRemoteTable {
  @override
  String table;
  String base;
  AirtableTable(this.table, this.base);

  @override
  Future<Map<String, dynamic>> records() async {
    return await Client.defaultClient(table: table, base: base).records();
  }

  @override
  Future<Map<String, dynamic>> create(Map<String, dynamic> parameters) {
    // TODO: implement create
    throw UnimplementedError();
  }
}
