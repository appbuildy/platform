import 'package:flutter_app/features/schemaNodes/RemoteSchemaPropertiesBinding.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';

abstract class IRemoteAttribute {
  String id;
  String field;

  String name();
  void bind(RemoteSchemaPropertiesBinding bindings, SchemaNodeProperty prop);
  String get value => value;
  set value(String val) => value = val;
}

class AirtableAttribute implements IRemoteAttribute {
  String id;
  String field;
  AirtableAttribute(this.id, this.field);

  @override
  void bind(RemoteSchemaPropertiesBinding bindings, SchemaNodeProperty prop) {
    bindings.addMapping(prop, this);
  }

  @override
  String name() {
    return "$id/$field";
  }

  @override
  String value;
}
