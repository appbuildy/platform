import 'package:flutter_app/features/airtable/AirtableAttribute.dart';
import 'package:flutter_app/features/airtable/AirtableColumn.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/airtable/RemoteList.dart';
import 'package:flutter_app/features/airtable/airtable_table.dart';
import 'package:mobx/mobx.dart';

part 'RemoteAttributes.g.dart';

class RemoteAttributes = _RemoteAttributes with _$RemoteAttributes;

abstract class _RemoteAttributes with Store {
  _RemoteAttributes(
      {List<IRemoteAttribute> attributes = const [],
      ObservableMap<String, Map<String, RemoteList>> tables}) {
    this.attributes.addAll(attributes);
    this.tables = tables ?? ObservableMap<String, Map<String, RemoteList>>();
  }

  @observable
  ObservableList<IRemoteAttribute> attributes =
      ObservableList<IRemoteAttribute>();

  @observable
  ObservableMap<String, Map<String, RemoteList>> tables =
      ObservableMap<String, Map<String, RemoteList>>();

  @action
  Future<void> fetchTables(List<AirtableTable> tables) async {
    tables.forEach((table) {
      this.update(table);
    });
  }

  @computed
  List<String> get tableNames => tables.keys.toList();

  @action
  Future<void> update([IRemoteTable fetchClient]) async {
    IRemoteTable client = fetchClient;
    final columns = Map<String, RemoteList>();
    tables[client.table] = columns;

    final records = await client.records();
    print(records);
    records['records'].forEach((record) {
      record['fields'].forEach((key, val) {
        _addColumnUniq(columns, key);

        final attribute = AirtableAttribute(record['id'], key);
        attributes.add(attribute);
      });
    });
  }

  AirtableColumn _addColumnUniq(Map<String, RemoteList> columns, key) {
    final column = AirtableColumn(key);
    final foundColumn = columns[key];

    if (foundColumn == null) {
      columns[key] = column;
      return column;
    } else {
      return foundColumn;
    }
  }
}
