import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:mobx/mobx.dart';

part 'CurrentEditingElement.g.dart';

class CurrentEditingElement = _CurrentEditingElement
    with _$CurrentEditingElement;

abstract class _CurrentEditingElement with Store {
  @observable
  SchemaNode selectedElement;

  @action
  void select(SchemaNode node) {
    selectedElement = node;
  }
}
