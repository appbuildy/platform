import 'package:flutter_app/features/entities/User.dart';

class NotLoggedInUser extends User {
  @override
  bool loggedIn() {
    return false;
  }

  @override
  // TODO: implement name
  String get name => "Not Logged In";
}
