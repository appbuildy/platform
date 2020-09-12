import 'dart:developer';

import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';

class AddScreen extends BaseAction {
  String name;
  List<SchemaNode> components;
  bool bottomTabsVisible;
  ScreensStore screensStore;
  SchemaStore createdScreen;
  bool executed;
  AddScreen(
      {this.components,
      this.bottomTabsVisible,
      this.name = '',
      this.screensStore});

  @override
  void execute() {
    executed = true;
    final newName = name.isEmpty ? _generatedNameForNewScreen() : name;
    final newComponents = components != null ? components : [];

    log('new components $newComponents');

    final newBottomTabsVisible =
        bottomTabsVisible != null ? bottomTabsVisible : true;
    createdScreen = SchemaStore(
        components: newComponents,
        bottomTabsVisible: newBottomTabsVisible,
        name: newName);
    screensStore.createScreen(createdScreen);
  }

  @override
  void redo() {}

  @override
  void undo() {
    if (!executed) return;
    screensStore.deleteScreen(createdScreen);
  }

  _generatedNameForNewScreen() {
    final number = screensStore.screens.length + 1;
    return 'Page $number';
  }
}
