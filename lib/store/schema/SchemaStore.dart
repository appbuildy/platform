import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:mobx/mobx.dart';

part 'SchemaStore.g.dart';

class SchemaStore = _SchemaStore with _$SchemaStore;

abstract class _SchemaStore with Store {
  _SchemaStore({List<SchemaNode> components}) {
    this.components = ObservableList<SchemaNode>();
    this.components.addAll(components);
  }

  @observable
  ObservableList<SchemaNode> components = ObservableList<SchemaNode>();

  @action
  void add(SchemaNode schemaNode) {
    components.add(schemaNode);
  }

  @action
  void update(SchemaNode schemaNode) {
    final index =
        components.indexWhere((element) => element.id == schemaNode.id);
    components.replaceRange(index, index + 1, [schemaNode]);
  }

  @action
  void remove(SchemaNode schemaNode) {
    components.remove(schemaNode);
  }
}
