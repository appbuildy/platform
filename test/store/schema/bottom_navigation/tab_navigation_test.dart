import 'package:flutter_app/features/layout/MAIN_UNIQUE_KEY.dart';
import 'package:flutter_app/store/schema/bottom_navigation/tab_navigation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  test('.toJson()', () {
    final tab = TabNavigation(
        label: 'Home', icon: FontAwesomeIcons.home, target: MAIN_UNIQUE_KEY);
    expect(tab.toJson()['label'], equals(tab.label));
  });

  test('.fromJson()', () {
    final tab = TabNavigation(
        label: 'Home', icon: FontAwesomeIcons.home, target: MAIN_UNIQUE_KEY);

    final jsonGen = tab.toJson();
    print(jsonGen);
    expect(TabNavigation.fromJson(jsonGen).icon, equals(tab.icon));
  });
}
