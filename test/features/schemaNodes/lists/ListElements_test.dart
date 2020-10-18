import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ListElement', () {
    final element =
        ListElement(column: 'Something', type: ListElementType.title);
    test('.toJson() serialization', () {
      expect(element.toJson()['column'], equals('Something'));
    });

    test('.fromJson() deserializes', () {
      final jsonVar = element.toJson();
      final deserialized = ListElement.fromJson(jsonVar);
      expect(deserialized.type, equals(element.type));
    });
  });

  test('.toJson() serializes to json', () {
    final listElements = ListElements();
    final ListElementsProperty prop =
        ListElementsProperty('Elements', listElements);

    prop.toJson();
  });
}
