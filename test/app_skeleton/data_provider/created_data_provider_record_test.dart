import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteTable extends Mock implements IRemoteTable {}

void main() {
  var remoteTable = MockRemoteTable();
  test('create persists record to remote table', () {
    remoteTable.create({});
    when(remoteTable.create(any)).thenAnswer((_) async => {});
    verify(remoteTable.create({})).called(1);
  });
}
