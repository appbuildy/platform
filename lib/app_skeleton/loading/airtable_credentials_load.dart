import 'package:flutter_app/features/airtable/Client.dart';

class AirtableCredentialsLoad {
  Map<String, dynamic> jsonData;
  AirtableCredentialsLoad(this.jsonData);

  void load() {
    AirtableClient.credentials = {
      'api_key': jsonData['airtable_credentials']['api_key'],
      'base': jsonData['airtable_credentials']['base']
    };
  }
}
