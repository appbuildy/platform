import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it adds components to state', () {
    final canvas = SchemaStore(components: []);
    canvas.components = [SchemaNodeButton(position: Offset.zero)];
    canvas.add(SchemaNodeButton(position: Offset.zero));
    expect(canvas.components.length, equals(2));
  });

  test('.remove() removes given element from the list', () {
    final canvas = SchemaStore(components: []);
    canvas.components = [SchemaNodeButton(position: Offset.zero)];
    final latestButton = SchemaNodeButton(position: Offset.zero);
    canvas.add(latestButton);
    canvas.remove(latestButton);
    expect(canvas.components.length, equals(1));
  });
}
