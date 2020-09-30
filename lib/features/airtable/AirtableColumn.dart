import 'package:flutter_app/features/airtable/AirtableAttribute.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/airtable/RemoteList.dart';

class AirtableColumn implements RemoteList {
  @override
  List<IRemoteAttribute> list;

  @override
  String name;
  AirtableColumn(String name, List<AirtableAttribute> list) {
    this.list = list;
    this.name = name;
  }
}
