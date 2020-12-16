import 'package:flutter_app/features/schemaInteractions/SelectNodeForPropsEdit.dart';
import 'package:flutter_app/features/schemaInteractions/SetupUserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_app/store/userActions/CurrentEditingElement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it selects node for props edit', () {
    CurrentEditingNode currentElement = CurrentEditingNode();
    SchemaNodeSpawner nodeSpawner = SchemaNodeSpawner(userActions: setupUserActions());

    final SchemaNodeButton node = nodeSpawner.spawnSchemaNodeButton(position: Offset(1, 3));
    final SelectNodeForPropsEdit action =
        SelectNodeForPropsEdit(node, currentElement);
    action.execute();

    expect(currentElement.selectedNode, isNotNull);
  });
}
