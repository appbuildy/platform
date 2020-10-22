import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/schemaNodes/RemoteSchemaPropertiesBinding.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class AirtableAttribute implements IRemoteAttribute {
  AirtableAttribute(String id, String field) {
    this.id = id;
    this.field = field;
    this.connectedProperties = <SchemaNodeProperty>[];
  }

  @override
  void bind(RemoteSchemaPropertiesBinding bindings, SchemaNodeProperty prop) {
    bindings.addMapping(prop, this);
    this.connectedProperties.add(prop);
  }

  @override
  String name() {
    return "$id/$field";
  }

  @override
  String value;

  @override
  List<SchemaNodeProperty> connectedProperties;

  @override
  String field;

  @override
  String id;

  @override
  void updateValues() {
    this.connectedProperties.forEach((element) {
      element.value = this.value;
    });
  }
}
