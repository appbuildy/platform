import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

part 'RemoteAttributes.g.dart';

class RemoteAttributes = _RemoteAttributes with _$RemoteAttributes;

abstract class _RemoteAttributes with Store {
  _RemoteAttributes(this.attributes);

  @observable
  ObservableList<String> attributes = ObservableList<String>();

  @action
  void updateAttributes(ObservableList<String> list) {}

  void update() async {
    IRemoteTable client = Client(
        table: 'Table%201',
        apiKey: 'keyzl1cUgqEpq4zBB',
        base: 'apphUx0izMa4P5pzQ',
        httpClient: http.Client());
    final records = await client.records();
    print(records);
  }
}
