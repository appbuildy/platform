import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/schemaNodes/IRemoteValue.dart';

class RemoteTextValue implements IRemoteValue<String> {
  AirtableClient client;
  String remoteId;
  String fieldName;
  RemoteTextValue(this.client, this.remoteId, this.fieldName);

  @override
  Future<String> fetch() async {
    final response = await this.client.record(remoteId);
    return response['fields'][fieldName].toString();
  }
}
