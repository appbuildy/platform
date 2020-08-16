import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:mobx/mobx.dart';

part 'SchemaStore.g.dart';

class SchemaStore = _SchemaStore with _$SchemaStore;

abstract class _SchemaStore with Store {
  _SchemaStore({List<SchemaNode> components}) {
    this.components = components;
  }

  @observable
  ObservableList<SchemaNode> components = ObservableList<SchemaNode>();

  @action
  void add(SchemaNode schemaNode) {
    components = [...components, schemaNode];
  }

  @action
  void update(SchemaNode schemaNode) {
    final modified = [...components];
    final index = modified.indexWhere((element) => element.id == schemaNode.id);
    modified.replaceRange(index, index + 1, [schemaNode]);

    components = [...modified];
  }

  @action
  void remove(SchemaNode schemaNode) {
    components.remove(schemaNode);
  }
}
