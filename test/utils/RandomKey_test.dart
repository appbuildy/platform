import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('JSON serialization', () {
    final key = RandomKey();
    final jsonVal = key.toJson();

    expect(jsonVal['value'], equals(key.value));
    expect(RandomKey.fromJson(jsonVal), equals(key));
  });
}
