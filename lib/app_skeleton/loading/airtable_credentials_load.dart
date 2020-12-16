import 'package:flutter_app/features/airtable/Client.dart';

class AirtableCredentialsLoad {
  Map<String, dynamic> jsonData;
  AirtableCredentialsLoad(this.jsonData);

  void load() {
    Client.credentials = {
      'api_key': jsonData['airtable_credentials']['api_key']
    };
  }
}
