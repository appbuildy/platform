import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:mobx/mobx.dart';

part 'CurrentEditingElement.g.dart';

class CurrentEditingNode = _CurrentEditingNode with _$CurrentEditingNode;

abstract class _CurrentEditingNode with Store {
  @observable
  SchemaNode selectedNode;

  @action
  void select(SchemaNode node) {
    selectedNode = node;
  }
}
