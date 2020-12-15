import 'package:flutter_app/features/airtable/RemoteAttribute.dart';

abstract class RemoteList {
  String name;
  String table;
  List<IRemoteAttribute> list;
}
