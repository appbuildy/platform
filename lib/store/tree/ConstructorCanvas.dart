import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:mobx/mobx.dart';

part 'ConstructorCanvas.g.dart';

class ConstructorCanvas = _ConstructorCanvas with _$ConstructorCanvas;

abstract class _ConstructorCanvas with Store {
  _ConstructorCanvas({List<SchemaNode> components}) {
    this.components = components;
  }

  @observable
  List<SchemaNode> components = [];

  @action
  void add(SchemaNode widgetWrapper) {
    components.add(widgetWrapper);
  }
}
