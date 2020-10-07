import 'package:flutter_app/features/entities/CurrentUser.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/entities/User.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

class MockedClient extends MockClient {
  MockedClient(fn) : super(fn);
}

class MockUser extends Mock implements User {}

final responseBody =
    '{ "airtable_credentials" : { "api_key": "key123", "base":"base123" } }';

void main() {
  test('getData() fetches data from give url', () async {
    final url = "https://back.com/projects/1";
    final user = MockUser();

    var client = MockClient((request) async {
      return Response(responseBody, 200, request: request);
    });
    final project = Project(url, user);
    final data = await project.getData(client);
    expect(data['airtable_credentials']['api_key'], equals('key123'));
  });
}
