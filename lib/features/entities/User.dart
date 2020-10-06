import 'package:http/http.dart' as http;

abstract class User {
  bool loggedIn();
  String get name;
  String dataUrl;
  Future<List<String>> tables(http.Client client);
}
