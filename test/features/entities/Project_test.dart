import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/entities/User.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/utils/SchemaConverter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

class MockedClient extends MockClient {
  MockedClient(fn) : super(fn);
}

class MockUser extends Mock implements User {
  Map<String, String> authHeaders() {
    return {};
  }
}

class MockHttp extends Mock implements Client {}

void main() {
  final responseBody =
      '{ "airtable_credentials" : { "api_key": "key123", "base":"base123" } }';
  final url = "https://back.com/projects/1";
  final user = MockUser();
  final project = Project(url, user);

  test('getData() fetches data from give url', () async {
    var client = MockClient((request) async {
      return Response(responseBody, 200, request: request);
    });
    final data = await project.getData(client);
    expect(data['airtable_credentials']['api_key'], equals('key123'));
  });

  test('save() saves project by sending PATCH request on a given URL',
      () async {
    final client = MockHttp();
    ScreensStore store = ScreensStore();
    SchemaConverter converter =
        SchemaConverter(store, MyThemes.allThemes['blue']);
    await project.save(converter, client: client);

    verify(client.patch(url,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .called(1);
  });
}
