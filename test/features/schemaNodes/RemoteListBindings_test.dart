import 'package:flutter_app/features/airtable/AirtableAttribute.dart';
import 'package:flutter_app/features/airtable/AirtableColumn.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteList.dart';
import 'package:flutter_app/features/schemaNodes/RemoteSchemaPropertiesBinding.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  test('update() fetches remote data using table', () async {
    final list = SchemaStringListProperty.sample();
    final Map<String, RemoteList> table = {
      'Column':
          AirtableColumn('Column', [AirtableAttribute('123', 'F i e l d')])
    };
  });
}
