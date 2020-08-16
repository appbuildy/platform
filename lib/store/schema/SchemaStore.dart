import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:mobx/mobx.dart';

part 'SchemaStore.g.dart';

class SchemaStore = _SchemaStore with _$SchemaStore;

abstract class _SchemaStore with Store {
  _SchemaStore({List<SchemaNode> components}) {
    this.components = components;
  }

  @observable
  List<SchemaNode> components = [];

  @action
  void add(SchemaNode schemaNode) {
    components.add(schemaNode);
  }
}
