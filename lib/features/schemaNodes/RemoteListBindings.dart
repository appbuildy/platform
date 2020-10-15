import 'package:flutter_app/features/airtable/RemoteList.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';

class RemoteListBindings {
  Map<String, RemoteList> table;
  SchemaListItemsProperty listProperty;

  RemoteListBindings(this.table, this.listProperty);
}
