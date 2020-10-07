import 'package:flutter_app/features/entities/CurrentUser.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/features/services/SettingsParser.dart';
import 'package:flutter_app/features/services/SetupProject.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

class MockUser extends Mock implements CurrentUserStore {}

class UserInstanceMock extends Mock implements CurrentUser {}

class MockSettings extends Mock implements SettingsParser {}

final responseBody =
    '{ "airtable_credentials" : { "api_key": "key123", "base":"base123" } }';

class MockedClient extends MockClient {
  MockedClient(fn) : super(fn);
}

class AuthenticationServiceMock extends Mock implements AuthenticationService {}

void main() {
  test('getData() fetches data from give url', () async {
    final auth = AuthenticationServiceMock();
    final userMock = MockUser();
    when(userMock.currentUser).thenReturn(UserInstanceMock());

    final SetupProject setup = SetupProject(userMock, MockSettings());
    var client = MockClient((request) async {
      return Response(responseBody, 200, request: request);
    });
    setup.setup(auth, client);
  });
}
