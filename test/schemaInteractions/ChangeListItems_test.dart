import 'dart:io';

import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  test('it authenticates user', () async {
    final mockClient = MockClient();
    final url = "example.com";
    final responseBody = '{"name": "Fucking Test"}';

    when(mockClient
            .get(url, headers: {HttpHeaders.authorizationHeader: "Bearer jwt"}))
        .thenAnswer((_) async => http.Response(responseBody, 200));

    final user =
        await AuthenticationService(url: url, jwt: 'jwt', client: mockClient)
            .authenticate();

    expect(user.name, equals('Fucking Test'));
  });
}
