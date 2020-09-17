import 'package:flutter_app/features/schemaNodes/RemoteSchemaPropertiesBinding.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';

abstract class IRemoteAttribute {
  String name();
  void bind(RemoteSchemaPropertiesBinding bindings, SchemaNodeProperty prop);
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
}
