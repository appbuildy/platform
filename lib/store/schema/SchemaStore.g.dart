// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SchemaStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SchemaStore on _SchemaStore, Store {
  final _$idAtom = Atom(name: '_SchemaStore.id');

  @override
  UniqueKey get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(UniqueKey value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$componentsAtom = Atom(name: '_SchemaStore.components');

  @override
  ObservableList<SchemaNode> get components {
    _$componentsAtom.reportRead();
    return super.components;
  }

  @override
  set components(ObservableList<SchemaNode> value) {
    _$componentsAtom.reportWrite(value, super.components, () {
      super.components = value;
    });
  }

  final _$detailedInfoAtom = Atom(name: '_SchemaStore.detailedInfo');

  @override
  DetailedInfo get detailedInfo {
    _$detailedInfoAtom.reportRead();
    return super.detailedInfo;
  }

  @override
  set detailedInfo(DetailedInfo value) {
    _$detailedInfoAtom.reportWrite(value, super.detailedInfo, () {
      super.detailedInfo = value;
    });
  }

  final _$backgroundColorAtom = Atom(name: '_SchemaStore.backgroundColor');

  @override
  MyThemeProp get backgroundColor {
    _$backgroundColorAtom.reportRead();
    return super.backgroundColor;
  }

  @override
  set backgroundColor(MyThemeProp value) {
    _$backgroundColorAtom.reportWrite(value, super.backgroundColor, () {
      super.backgroundColor = value;
    });
  }

  final _$bottomTabsVisibleAtom = Atom(name: '_SchemaStore.bottomTabsVisible');

  @override
  bool get bottomTabsVisible {
    _$bottomTabsVisibleAtom.reportRead();
    return super.bottomTabsVisible;
  }

  @override
  set bottomTabsVisible(bool value) {
    _$bottomTabsVisibleAtom.reportWrite(value, super.bottomTabsVisible, () {
      super.bottomTabsVisible = value;
    });
  }

  final _$nameAtom = Atom(name: '_SchemaStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$_SchemaStoreActionController = ActionController(name: '_SchemaStore');

  @override
  void setDetailedInfo(DetailedInfo newDetailedInfo) {
    final _$actionInfo = _$_SchemaStoreActionController.startAction(
        name: '_SchemaStore.setDetailedInfo');
    try {
      return super.setDetailedInfo(newDetailedInfo);
    } finally {
      _$_SchemaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBackgroundColor(MyThemeProp color) {
    final _$actionInfo = _$_SchemaStoreActionController.startAction(
        name: '_SchemaStore.setBackgroundColor');
    try {
      return super.setBackgroundColor(color);
    } finally {
      _$_SchemaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBottomTabs(bool newValue) {
    final _$actionInfo = _$_SchemaStoreActionController.startAction(
        name: '_SchemaStore.setBottomTabs');
    try {
      return super.setBottomTabs(newValue);
    } finally {
      _$_SchemaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String newName) {
    final _$actionInfo = _$_SchemaStoreActionController.startAction(
        name: '_SchemaStore.setName');
    try {
      return super.setName(newName);
    } finally {
      _$_SchemaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void add(SchemaNode schemaNode) {
    final _$actionInfo =
        _$_SchemaStoreActionController.startAction(name: '_SchemaStore.add');
    try {
      return super.add(schemaNode);
    } finally {
      _$_SchemaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(SchemaNode schemaNode) {
    final _$actionInfo =
        _$_SchemaStoreActionController.startAction(name: '_SchemaStore.update');
    try {
      return super.update(schemaNode);
    } finally {
      _$_SchemaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void bringFront(SchemaNode schemaNode) {
    final _$actionInfo = _$_SchemaStoreActionController.startAction(
        name: '_SchemaStore.bringFront');
    try {
      return super.bringFront(schemaNode);
    } finally {
      _$_SchemaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendBack(SchemaNode schemaNode) {
    final _$actionInfo = _$_SchemaStoreActionController.startAction(
        name: '_SchemaStore.sendBack');
    try {
      return super.sendBack(schemaNode);
    } finally {
      _$_SchemaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(SchemaNode schemaNode) {
    final _$actionInfo =
        _$_SchemaStoreActionController.startAction(name: '_SchemaStore.remove');
    try {
      return super.remove(schemaNode);
    } finally {
      _$_SchemaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
components: ${components},
detailedInfo: ${detailedInfo},
backgroundColor: ${backgroundColor},
bottomTabsVisible: ${bottomTabsVisible},
name: ${name}
    ''';
  }
}
