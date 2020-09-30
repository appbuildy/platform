import 'package:flutter_app/features/schemaNodes/RemoteSchemaPropertiesBinding.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';

abstract class IRemoteAttribute {
  String id;
  String field;
  List<SchemaNodeProperty> connectedProperties;

  String name();
  void bind(RemoteSchemaPropertiesBinding bindings, SchemaNodeProperty prop);
  String get value => value;
  set value(String val) => value = val;
  void updateValues();
}
