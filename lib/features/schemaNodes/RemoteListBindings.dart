import 'package:flutter_app/features/airtable/RemoteList.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';

class RemoteListBindings {
  Map<String, RemoteList> table;
  SchemaListItemProperty listProperty;

  RemoteListBindings(this.table, this.listProperty);
}
