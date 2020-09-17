import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class RemoteSchemaPropertiesBinding {
  IRemoteTable remoteTable;
  Map<String, SchemaNodeProperty> mappings;
  RemoteSchemaPropertiesBinding(IRemoteTable remoteTable,
      [Map<String, SchemaNodeProperty> mappings]) {
    this.remoteTable = remoteTable;
    this.mappings = mappings ?? {};
  }

  void addMapping(SchemaNodeProperty prop, AirtableAttribute attribute) {
    mappings['${attribute.id}/${attribute.field}'] = prop;
  }

  Future<Map<String, SchemaNodeProperty>> update() async {
    final response = await this.remoteTable.records();
    final records = response['records'];
    records.forEach((record) {
      record['fields'].forEach((fieldKey, fieldVal) {
        final key = "${record['id']}/$fieldKey";
        final mapping = mappings[key];

        if (mapping != null) {
          print(mapping);
          mapping.value = fieldVal;
        }
      });
    });
    return mappings;
  }
}
