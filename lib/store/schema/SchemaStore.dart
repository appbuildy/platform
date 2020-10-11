import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:mobx/mobx.dart';

part 'SchemaStore.g.dart';

class SchemaStore = _SchemaStore with _$SchemaStore;

class DetailedInfo {
  String tableName;
  UniqueKey screenId;
  Map<String, ListItem> rowData;

  DetailedInfo(
      {@required String tableName,
      @required UniqueKey screenId,
      @required Map<String, ListItem> rowData}) {
    this.tableName = tableName;
    this.screenId = screenId;
    this.rowData = rowData;
  }
}

abstract class _SchemaStore with Store {
  _SchemaStore(
      {@required List<SchemaNode> components,
      @required name,
      bool bottomTabsVisible,
      DetailedInfo detailedInfo,
      id}) {
    this.components = ObservableList<SchemaNode>();
    this.components.addAll(components);
    this.name = name;
    this.detailedInfo = detailedInfo;
    this.id = id ?? UniqueKey();
    this.bottomTabsVisible = bottomTabsVisible ?? true;
  }
  @observable
  UniqueKey id;

  @observable
  ObservableList<SchemaNode> components = ObservableList<SchemaNode>();

  @observable
  DetailedInfo detailedInfo;

  @action
  void setDetailedInfo(DetailedInfo newDetailedInfo) {
    detailedInfo = newDetailedInfo;
  }

  @observable
  bool bottomTabsVisible;

  @action
  void setBottomTabs(bool newValue) {
    bottomTabsVisible = newValue;
  }

  @observable
  String name;

  @action
  void setName(String newName) {
    name = newName;
  }

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
  void bringFront(SchemaNode schemaNode) {
    final index =
        components.indexWhere((element) => element.id == schemaNode.id);
    components.removeAt(index);
    components.add(schemaNode);
  }

  @action
  void sendBack(SchemaNode schemaNode) {
    final index =
        components.indexWhere((element) => element.id == schemaNode.id);
    components.removeAt(index);
    components.insert(0, schemaNode);
  }

  @action
  void remove(SchemaNode schemaNode) {
    components.removeWhere((element) => element.id == schemaNode.id);
  }

  Map<String, dynamic> toJson() =>
      {'components': components.map((comp) => comp.toJson()).toList()};
}
