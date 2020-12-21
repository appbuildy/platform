import 'package:flutter_app/app_skeleton/loading/airtable_credentials_load.dart';
import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it sets credentials', () {
    var data = {
      'airtable_credentials': {
        'base': 'https://airtable.com/shrRZPMRGEuB2PJgR',
        'api_key': '321321'
      }
    };

    var loader = AirtableCredentialsLoad(data);
    loader.load();
    expect(AirtableClient.credentials['api_key'],
        equals(data['airtable_credentials']['api_key']));
  });
}
