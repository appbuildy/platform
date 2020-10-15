import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/airtable/AirtableAttribute.dart';
import 'package:flutter_app/features/airtable/Client.dart' as airtable;
import 'package:flutter_app/features/airtable/RemoteAttribute.dart';
import 'package:flutter_app/features/airtable/RemoteList.dart';
import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaInteractions/ChangeNodeProperty.dart';
import 'package:flutter_app/features/schemaInteractions/CopyNode.dart';
import 'package:flutter_app/features/schemaInteractions/DeleteNode.dart';
import 'package:flutter_app/features/schemaInteractions/PlaceWidget.dart';
import 'package:flutter_app/features/schemaInteractions/RepositionAndResize.dart';
import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/SelectNodeForPropsEdit.dart';
import 'package:flutter_app/features/schemaNodes/ChangeableProperty.dart';
import 'package:flutter_app/features/schemaNodes/RemoteSchemaPropertiesBinding.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/services/projects/LoadedProject.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/userActions/ActionsDone.dart';
import 'package:flutter_app/store/userActions/ActionsUndone.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/store/userActions/CurrentEditingElement.dart';
import 'package:flutter_app/store/userActions/RemoteAttributes.dart';
import 'package:flutter_app/utils/SchemaConverter.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart';

import 'ConnectToRemoteAttribute.dart';

class UserActions {
  ActionsDone _actionsDone;
  ActionsUndone _actionsUndone;
  CurrentEditingNode _currentNode;
  Screens _screens;
  BottomNavigationStore _bottomNavigation;
  AppThemeStore _theme;
  CurrentUserStore _currentUserStore;
  RemoteAttributes _remoteAttributes;
  RemoteSchemaPropertiesBinding _bindings;
  List<String> remoteTableNames;

  UserActions(
      {Screens screens,
      CurrentUserStore currentUserStore,
      BottomNavigationStore bottomNavigationStore,
      AppThemeStore themeStore}) {
    _actionsDone = new ActionsDone(actions: []);
    _actionsUndone = new ActionsUndone(actions: []);
    _currentNode = CurrentEditingNode();
    _bottomNavigation = bottomNavigationStore;
    _remoteAttributes = RemoteAttributes();
    _bindings = RemoteSchemaPropertiesBinding(airtable.Client.defaultClient());
    _theme = themeStore;
    _screens = screens;
    _currentUserStore = currentUserStore;

    this.loadProject();
  }

  SchemaStore get currentScreen => _screens.current;

  Screens get screens => _screens;

  BottomNavigationStore get bottomNavigation => _bottomNavigation;

  AppThemeStore get themeStore => _theme;

  MyTheme get currentTheme => _theme.currentTheme;

  List<String> get tables => _remoteAttributes.tableNames;

  List<RemoteList> columnsFor(String tableName) {
    return _remoteAttributes.tables[tableName].values.toList();
  }

  CurrentUserStore get currentUserStore => _currentUserStore;

  void setTheme(MyTheme theme) {
    _theme.setTheme(theme);

    _screens.all.screens.forEach((screen) {
      String backgroundColorName =
          screen.backgroundColor?.name ?? theme.background.name;
      screen.setBackgroundColor(theme.getThemePropByName(backgroundColorName));
    });
  }

  Future<void> loadProject() async {
    await _currentUserStore.setupProject(window, _remoteAttributes);
    final Screens screens =
        LoadedProject(_currentUserStore.project.data['canvas']).load();
    _screens = screens;
    print(
        "Loaded: $screens. Components: ${screens.all.screens.first.components}");
    this.startAutoSave();
  }

  void changeActionTo(ChangeableProperty prop,
      [bool isAddedToDoneActions = true, prevValue]) {
    final action = ChangeNodeProperty(
        selectNodeForEdit: selectNodeForEdit,
        schemaStore: currentScreen,
        changeAction: ChangeAction.actions,
        node: selectedNode(),
        newProp: prop);

    action.execute(prevValue);
    if (isAddedToDoneActions) {
      _actionsDone.add(action);
    }
  }

  void updateRemoteAttributeValues() {
    if (currentScreen != null && selectedNode() != null) {
      this._bindings.update(currentScreen, selectedNode());
    } else {
      this._bindings.update();
    }
  }

  void startAutoSave() {
    Timer.periodic(new Duration(seconds: 10), (timer) {
      final converter = SchemaConverter(screens.all);
      _currentUserStore.project.save(converter, client: http.Client());
    });
  }

  void changePropertyTo(ChangeableProperty prop,
      [bool isAddedToDoneActions = true, prevValue]) {
    final action = ChangeNodeProperty(
        selectNodeForEdit: selectNodeForEdit,
        schemaStore: currentScreen,
        node: selectedNode(),
        newProp: prop);

    action.execute(prevValue);
    if (isAddedToDoneActions) {
      _actionsDone.add(action);
    }
  }

  void rerenderNode() {
    currentScreen.update(selectedNode());
  }

  void copyNode(SchemaNode node,) {
    final action = new CopyNode(
        node: node,
        schemaStore: currentScreen,
        selectNodeForEdit: selectNodeForEdit);

    action.execute();
    _actionsDone.add(action);
  }

  void deleteNode(SchemaNode node,) {
    final action = new DeleteNode(
        node: node,
        schemaStore: currentScreen,
        selectNodeForEdit: selectNodeForEdit);

    action.execute();
    _actionsDone.add(action);
  }

  BaseAction lastAction() {
    // ignore: unnecessary_statements
    return _actionsDone.isActionsEmpty ? null : _actionsDone.actions.last;
  }

  bool get isActionsDoneEmpty => _actionsDone.isActionsEmpty;

  SchemaNode placeWidget(SchemaNode node, Offset position) {
    final action = new PlaceWidget(
        node: node,
        schemaStore: currentScreen,
        position: position,
        selectNodeForEdit: selectNodeForEdit);

    action.execute();
    _actionsDone.add(action);

    return action.newNode;
  }

  void repositionAndResize(SchemaNode updatedNode,
      [bool isAddedToDoneActions = true, SchemaNode prevValue]) {
    final action =
    RepositionAndResize(schemaStore: currentScreen, node: updatedNode);

    action.execute(prevValue);
    if (isAddedToDoneActions) {
      _actionsDone.add(action);
    }
  }

  SchemaNode selectedNode() {
    return _currentNode.selectedNode;
  }

  void selectNodeForEdit(SchemaNode node) {
    SelectNodeForPropsEdit(node, _currentNode).execute();
  }

  void bindAttribute({SchemaNodeProperty property, AirtableAttribute attribute}) {
    final action = ConnectToRemoteAttribute(_bindings, attribute, property);
    action.execute();
    _actionsDone.add(action);
  }

  List<IRemoteAttribute> remoteAttributeList() {
    return _remoteAttributes.attributes;
  }

  void undo() {
    if (lastAction() == null) return;

    final removedAction = _actionsDone.actions.removeLast();
    removedAction.undo();
    _actionsUndone.add((removedAction));
  }
}
