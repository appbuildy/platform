import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/store/schema/bottom_navigation/tab_navigation.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  group('.addTab()', () {
    test('it adds tab', () {
      var tab = TabNavigation(
          id: RandomKey(),
          label: 'Test',
          icon: IconDataBrands(322),
          target: RandomKey());

      var store = BottomNavigationStore();
      store.addTab(tab);
      expect(store.tabs.length, equals(2));
    });
  });

  test('.toJson() serialization', () {
    var store = BottomNavigationStore();
    expect(store.toJson()['tabs'][0]['label'], equals(store.tabs[0].label));
  });

  test('.fromJson', () {
    var storeJson = BottomNavigationStore();
    var storeSerialized = storeJson.toJson();

    var storeDeserialized = BottomNavigationStore.fromJson(storeSerialized);

    expect(storeJson.tabs.first.id, equals(storeDeserialized.tabs.first.id));
  });
}
