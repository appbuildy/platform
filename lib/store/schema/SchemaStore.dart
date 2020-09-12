import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:mobx/mobx.dart';

part 'SchemaStore.g.dart';

class SchemaStore = _SchemaStore with _$SchemaStore;

abstract class _SchemaStore with Store {
  _SchemaStore({List<SchemaNode> components, name = 'Main'}) {
    this.components = ObservableList<SchemaNode>();
    this.components.addAll(components);
    this.name = name;
  }

  @observable
  ObservableList<SchemaNode> components = ObservableList<SchemaNode>();

  @observable
  bool bottomTabsVisible = true;

  @action
  void setBottomTabs(bool newValue) {
    bottomTabsVisible = newValue;
  }

  @observable
  String name;

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
    components.removeWhere((element) => element.id == schemaNode.id);
  }

  Map<String, dynamic> toJson() =>
      {'components': components.map((comp) => comp.toJson()).toList()};
}
