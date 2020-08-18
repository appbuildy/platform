import 'package:flutter_app/features/schemaInteractions/SelectNodeForPropsEdit.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/userActions/CurrentEditingElement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it selects node for props edit', () {
    CurrentEditingNode currentElement = CurrentEditingNode();
    final SchemaNodeButton node = SchemaNodeButton(position: Offset(1, 3));
    final SelectNodeForPropsEdit action =
        SelectNodeForPropsEdit(node, currentElement);
    action.execute();

    expect(currentElement.selectedNode, isNotNull);
  });
}
