import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/canvas/WidgetPosition.dart';
import 'package:flutter_app/store/tree/ConstructorCanvas.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it adds components to state', () {
    final canvas = ConstructorCanvas(components: []);
    canvas.components = [
      SchemaNode(
          type: SchemaNodeType.button, position: WidgetPosition(x: 1, y: 1))
    ];
    canvas.add(SchemaNode(
        type: SchemaNodeType.button, position: WidgetPosition(x: 1, y: 1)));
    expect(canvas.components.length, equals(2));
  });
}
