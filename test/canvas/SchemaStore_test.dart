import 'package:flutter_app/features/schemaInteractions/SetupUserActions.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it adds components to state', () {
    final canvas = SchemaStore(components: []);
    SchemaNodeSpawner nodeSpawner = SchemaNodeSpawner(userActions: setupUserActions());

    canvas.add(nodeSpawner.spawnSchemaNodeButton(position: Offset.zero));
    expect(canvas.components.length, equals(1));
  });

  test('.remove() removes given element from the list', () {
    SchemaNodeSpawner nodeSpawner = SchemaNodeSpawner(userActions: setupUserActions());
    final canvas = SchemaStore(components: []);
    final latestButton = nodeSpawner.spawnSchemaNodeButton(position: Offset.zero);
    canvas.add(latestButton);
    canvas.remove(latestButton);
    expect(canvas.components.length, equals(0));
  });
}
