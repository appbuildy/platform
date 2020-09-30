import 'package:flutter_app/features/airtable/AirtableAttribute.dart';
import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/airtable/RemoteList.dart';

class AirtableColumn implements RemoteList {
  @override
  List<IRemoteAttribute> list;

  @override
  String name;

  @override
  String table;

  AirtableColumn(String name, [List<AirtableAttribute> list, String table]) {
    this.list = list ?? [];
    this.name = name;
    this.table = table;
  }

  void add(AirtableAttribute attribute) {
    if (this.name != attribute.field) return;
    list.add(attribute);
  }
}
