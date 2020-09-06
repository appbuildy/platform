import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class RemoteSchemaPropertiesBinding {
  IRemoteTable remoteTable;
  Map<String, SchemaNodeProperty> mappings;
  RemoteSchemaPropertiesBinding(IRemoteTable remoteTable,
      [Map<String, SchemaNodeProperty> mappings]) {
    this.remoteTable = remoteTable;
    this.mappings = mappings ?? {};
  }

  void addMapping(String id, String name, SchemaNodeProperty prop) {
    mappings['$id/$name'] = prop;
  }

  Future<Map<String, SchemaNodeProperty>> update() async {
    final response = await this.remoteTable.records();
    final records = response['records'];
    records.forEach((record) {
      record['fields'].forEach((fieldKey, fieldVal) {
        final key = "${record['id']}/$fieldKey";
        final mapping = mappings[key];

        if (mapping != null) {
          mapping.value = fieldVal;
        }
      });
    });
    return mappings;
  }
}
