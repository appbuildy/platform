import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/schemaInteractions/SelectNodeForPropsEdit.dart';
import 'package:flutter_app/store/userActions/CurrentEditingElement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it selects node for props edit', () {
    CurrentEditingElement currentElement = CurrentEditingElement();
    final SchemaNodeButton node = SchemaNodeButton(position: Offset(1, 3));
    final SelectNodeForPropsEdit action =
        SelectNodeForPropsEdit(node, currentElement);
    action.execute();

    expect(currentElement.selectedElement, isNotNull);
  });
}
