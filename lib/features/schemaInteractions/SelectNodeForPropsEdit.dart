import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/store/userActions/CurrentEditingElement.dart';

class SelectNodeForPropsEdit {
  SchemaNode node;
  CurrentEditingElement currentElement;
  SelectNodeForPropsEdit(this.node, this.currentElement);

  void execute() {
    currentElement.select((node));
  }
}
