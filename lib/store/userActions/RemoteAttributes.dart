import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

part 'RemoteAttributes.g.dart';

class RemoteAttributes = _RemoteAttributes with _$RemoteAttributes;

abstract class _RemoteAttributes with Store {
  _RemoteAttributes({List<IRemoteAttribute> attributes = const []}) {
    this.attributes.addAll(attributes);
  }

  @observable
  ObservableList<IRemoteAttribute> attributes =
      ObservableList<IRemoteAttribute>();

  @action
  void updateAttributes(ObservableList<IRemoteAttribute> list) {}

  void update() async {
    IRemoteTable client = Client(
        table: 'Table%201',
        apiKey: 'keyzl1cUgqEpq4zBB',
        base: 'apphUx0izMa4P5pzQ',
        httpClient: http.Client());
    final records = await client.records();
    records['records'].forEach((record) {
      record['fields'].forEach((key, val) {
        attributes.add(AirtableAttribute(record['id'], key));
      });
    });
  }
}
