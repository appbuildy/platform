import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/schemaNodes/RemoteSchemaPropertiesBinding.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';

import 'BaseAction.dart';

class ConnectToRemoteAttribute extends BaseAction {
  IRemoteAttribute attribute;
  RemoteSchemaPropertiesBinding bindings;
  SchemaNodeProperty property;
  ConnectToRemoteAttribute(this.bindings, this.attribute, this.property);

  @override
  void execute() {
    attribute.bind(bindings, property);
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    // TODO: implement undo
  }
}
