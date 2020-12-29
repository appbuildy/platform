abstract class IRemoteTable {
  String table;
  Future<Map<String, dynamic>> records();
  Future<Map<String, dynamic>> create(Map<String, dynamic> parameters);
}
