import 'package:flutter_app/features/entities/CurrentUser.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/features/services/SetupProject.dart';
import 'package:flutter_app/features/services/browser_query_data.dart';
// import 'package:flutter_app/features/services/browser_query_data.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/store/userActions/RemoteAttributes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:universal_html/html.dart';

class MockUser extends Mock implements CurrentUserStore {}

class UserInstanceMock extends Mock implements CurrentUser {}

class MockBrowserQueryData extends Mock implements BrowserQueryData {
  String get jwt => '123';

  String get projectUrl => 'https://somewhere.com/projects/1';
}

BrowserQueryData mockBrowserData = MockBrowserQueryData();

class MockAttributes extends Mock implements RemoteAttributes {}

final responseBody =
    '{ "tables": [],"airtable_credentials" : { "api_key": "key123", "base":"base123" } }';

class MockedClient extends MockClient {
  MockedClient(fn) : super(fn);
}

class AuthenticationServiceMock extends Mock implements AuthenticationService {}

void main() {
  test('getData() fetches data from give url', () async {
    final auth = AuthenticationServiceMock();
    final userMock = MockUser();
    final attributesMock = MockAttributes();
    when(userMock.currentUser).thenReturn(UserInstanceMock());

    final SetupProject setup = SetupProject(
        userStore: userMock,
        // settings: MockSettings(),
        attributes: attributesMock);
    var client = MockClient((request) async {
      return Response(responseBody, 200, request: request);
    });
    await setup.setup(auth, client);

    verify(attributesMock.fetchTables(any)).called(1);
  });
}
