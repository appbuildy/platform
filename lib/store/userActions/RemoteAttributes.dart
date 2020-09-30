import 'package:flutter_app/features/airtable/AirtableAttribute.dart';
import 'package:flutter_app/features/airtable/AirtableColumn.dart';
import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/airtable/RemoteList.dart';
import 'package:mobx/mobx.dart';

part 'RemoteAttributes.g.dart';

class RemoteAttributes = _RemoteAttributes with _$RemoteAttributes;

abstract class _RemoteAttributes with Store {
  _RemoteAttributes(
      {List<IRemoteAttribute> attributes = const [],
      ObservableMap<String, List<RemoteList>> tables}) {
    this.attributes.addAll(attributes);
    this.tables = tables ?? ObservableMap<String, List<RemoteList>>();
  }

  @observable
  ObservableList<IRemoteAttribute> attributes =
      ObservableList<IRemoteAttribute>();

  @observable
  ObservableMap<String, List<RemoteList>> tables =
      ObservableMap<String, List<RemoteList>>();

  @action
  void updateAttributes(ObservableList<IRemoteAttribute> list) {}

  Future<void> update([IRemoteTable fetchClient]) async {
    IRemoteTable client = fetchClient ?? Client.defaultClient();
    final columns = List<RemoteList>();
    tables[client.table] = columns;

    final records = await client.records();
    records['records'].forEach((record) {
      record['fields'].forEach((key, val) {
        final column = AirtableColumn(key);
        _addColumn(columns, column);

        final attribute = AirtableAttribute(record['id'], key);
        attributes.add(attribute);
      });
    });
  }

  void _addColumn(List<RemoteList> columns, column) {
    if (columns.any((anyColumn) => anyColumn.name == column.name)) return;
    columns.add(column);
  }
}
