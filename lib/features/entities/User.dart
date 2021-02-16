import 'package:http/http.dart' as http;

abstract class User {
  bool loggedIn();
  String get name;
  String dataUrl;
  String email;

  Future<List<String>> tables(http.Client client);
  Map<dynamic, dynamic> authHeaders() {
    return {};
  }
}
