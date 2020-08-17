import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/userActions/CurrentEditingElement.dart';

class SelectNodeForPropsEdit {
  SchemaNode node;
  CurrentEditingNode currentElement;
  SelectNodeForPropsEdit(this.node, this.currentElement);

  void execute() {
    currentElement.select((node));
  }
}
