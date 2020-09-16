import 'package:flutter_app/features/schemaNodes/RemoteSchemaPropertiesBinding.dart';

abstract class IRemoteAttribute {
  String name();
  void bind(RemoteSchemaPropertiesBinding bindings);
}

class AirtableAttribute implements IRemoteAttribute {
  String id;
  String field;
  AirtableAttribute(this.id, this.field);

  @override
  void bind(RemoteSchemaPropertiesBinding bindings) {}

  @override
  String name() {
    return "$id/$field";
  }
}
