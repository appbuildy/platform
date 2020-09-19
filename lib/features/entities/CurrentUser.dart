import 'User.dart';

class CurrentUser extends User {
  String _name;
  String _JwtToken;
  CurrentUser(this._name, this._JwtToken);

  @override
  bool loggedIn() {
    return true;
  }

  @override
  String get name => _name;
}
