import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final theme = MyThemes.allThemes['blue'];

  test('.toJson() serealizes to json', () {
    expect(theme.toJson()['primary']['green'], equals(122));
  });

  test('.fromJson() loads', () {
    final jsonTheme = theme.toJson();
    expect(MyTheme.fromJson(jsonTheme).primary, equals(theme.primary));
  });
}
