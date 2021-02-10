import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';

class CreatedDataProviderRecord {
  IRemoteTable source;
  CreatedDataProviderRecord(this.source);

  factory CreatedDataProviderRecord.airtable(String tableName) {
    var client = Client.defaultClient(table: tableName);

    return CreatedDataProviderRecord(client);
  }

  Future<void> create(Map<String, dynamic> parameters) async {
    source.create(parameters);
  }
}
