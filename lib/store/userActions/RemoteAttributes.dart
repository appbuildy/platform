import 'package:flutter_app/features/airtable/AirtableAttribute.dart';
import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/airtable/RemoteList.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

part 'RemoteAttributes.g.dart';

class RemoteAttributes = _RemoteAttributes with _$RemoteAttributes;

abstract class _RemoteAttributes with Store {
  _RemoteAttributes(
      {List<IRemoteAttribute> attributes = const [],
      List<RemoteList> columns = const []}) {
    this.columns.addAll(columns);
    this.attributes.addAll(attributes);
  }

  @observable
  ObservableList<IRemoteAttribute> attributes =
      ObservableList<IRemoteAttribute>();

  @observable
  ObservableList<RemoteList> columns = ObservableList<RemoteList>();

  @action
  void updateAttributes(ObservableList<IRemoteAttribute> list) {}

  Future<void> update([IRemoteTable fetchClient]) async {
    IRemoteTable client = fetchClient ?? Client.defaultClient();

    final records = await client.records();
    records['records'].forEach((record) {
      record['fields'].forEach((key, val) {
        final attribute = AirtableAttribute(record['id'], key);
        attributes.add(attribute);
      });
    });
  }
}
