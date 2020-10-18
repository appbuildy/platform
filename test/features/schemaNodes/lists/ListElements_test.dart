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
    prop.value.title =
        ListElement(column: 'title', type: ListElementType.title);
    prop.value.image =
        ListElement(column: 'Image', type: ListElementType.image);
    prop.value.allColumns = List<String>.from(['1']);

    expect(prop.toJson()['value']['title']['column'], equals('title'));
    expect(prop.toJson()['value']['title']['navigationIcon'], equals(null));
    expect(prop.toJson()['value']['allColumns'], equals(['1']));
  });

  test('.fromJson()', () {
    final listElements = ListElements(
        allColumns: ['1'],
        title: ListElement(column: '322', type: ListElementType.title));
    final ListElementsProperty prop =
        ListElementsProperty('Elements', listElements);
    final jsonVal = prop.toJson();
    final deserialized = ListElementsProperty.fromJson(jsonVal);
    expect(deserialized.name, equals(prop.name));
    expect(deserialized.value.title.column, equals('322'));
  });
}
