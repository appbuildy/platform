import 'package:flutter_app/features/airtable/AirtableAttribute.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';

class RemoteSchemaPropertiesBinding {
  IRemoteTable remoteTable;
  Map<String, IRemoteAttribute> mappings;
  Map<String, IRemoteAttribute> listMappings;

  RemoteSchemaPropertiesBinding(IRemoteTable remoteTable,
      [Map<String, IRemoteAttribute> mappings]) {
    this.remoteTable = remoteTable;
    this.mappings = mappings ?? {};
    this.listMappings = listMappings ?? {};
  }

  void addMapping(SchemaNodeProperty prop, AirtableAttribute attribute) {
    final key = '${attribute.id}/${attribute.field}';
    prop.remoteAttribute = attribute;
    mappings[key] = attribute;
  }

  Future<Map<String, IRemoteAttribute>> update(
      [SchemaStore screen, SchemaNode node]) async {
    final response = await this.remoteTable.records();
    final records = response['records'];
    records.forEach((record) {
      record['fields'].forEach((fieldKey, fieldVal) {
        final key = "${record['id']}/$fieldKey";
        final mapping = mappings[key];

        if (mapping != null) {
          mapping.value = fieldVal;
          mapping.updateValues();
        }
      });
    });
    if (screen != null) {
      screen.update(node);
    }
    return mappings;
  }
}
