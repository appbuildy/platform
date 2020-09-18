import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class RemoteSchemaPropertiesBinding {
  IRemoteTable remoteTable;
  Map<String, IRemoteAttribute> mappings;

  RemoteSchemaPropertiesBinding(IRemoteTable remoteTable,
      [Map<String, IRemoteAttribute> mappings]) {
    this.remoteTable = remoteTable;
    this.mappings = mappings ?? {};
  }

  void addMapping(SchemaNodeProperty prop, AirtableAttribute attribute) {
    final key = '${attribute.id}/${attribute.field}';
    prop.remoteAttribute = attribute;
    mappings[key] = attribute;
  }

  Future<Map<String, IRemoteAttribute>> update() async {
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
