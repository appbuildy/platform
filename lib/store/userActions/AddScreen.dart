import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';

class AddScreen extends BaseAction {
  String name;
  ScreensStore screensStore;
  SchemaStore createdScreen;
  bool executed;
  AddScreen({this.name = '', this.screensStore});

  @override
  void execute() {
    executed = true;
    final newName = name.isEmpty ? _generatedNameForNewScreen() : name;
    createdScreen = SchemaStore(components: [], name: newName);
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
    return 'screen_$number';
  }
}
