abstract class IRemoteTable {
  String table;
  Future<Map<String, dynamic>> records();
}
