import 'dart:math';

class RandomKey {
  String value;
  RandomKey() {
    this.value = _initValue();
  }

  RandomKey.fromJson(Map<String, dynamic> jsonVal) {
    this.value = jsonVal['value'];
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }

  @override
  String toString() => value;

  RandomKey.fromString(String value) {
    this.value = value;
  }

  String _initValue({int length = 30}) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RandomKey && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
