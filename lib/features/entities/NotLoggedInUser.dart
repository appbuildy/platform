import 'package:flutter_app/features/entities/User.dart';
import 'package:http/src/client.dart';

class NotLoggedInUser extends User {
  @override
  bool loggedIn() {
    return false;
  }

  @override
  // TODO: implement name
  String get name => "Not Logged In";

  @override
  Future<List<String>> tables(Client client) async {
    return [];
  }
}
