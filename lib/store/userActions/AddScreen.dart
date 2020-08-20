import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';

class AddScreen extends BaseAction {
  String name;
  ScreensStore screensStore;
  bool executed;
  AddScreen([this.name = '', this.screensStore]);

  @override
  void execute() {
    executed = true;
    final newName = name.isEmpty ? _generatedNameForNewScreen() : name;
    screensStore.createScreen(SchemaStore(components: [], name: newName));
  }

  @override
  void redo() {
    // TODO: implement redo
  }

  @override
  void undo() {
    // TODO: implement undo
  }

  _generatedNameForNewScreen() {
    final number = screensStore.screens.length;
    return 'screen_$number';
  }
}
