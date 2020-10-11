import 'package:flutter_app/features/entities/CurrentUser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

class MockedClient extends MockClient {
  MockedClient(fn) : super(fn);
}

final responseBody = '{ "tables" : [{ "name": "table 1" }] }';

void main() {
  test('tables()', () async {
    final dataUrl = 'https://backend.com/me';

    var client = MockClient((request) async {
      return Response(responseBody, 200, request: request);
    });

    final CurrentUser user = CurrentUser('Sanek', '1231', dataUrl);
    final tables = await user.tables(client);
    expect(tables.first, equals('table 1'));
  });
}
