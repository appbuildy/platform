import 'package:flutter_app/features/schemaInteractions/BaseAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';

class DeleteScreen extends BaseAction {
  ScreensStore screensStore;
  SchemaStore deletedScreen;
  bool executed;
  DeleteScreen({this.screensStore});

  @override
  void execute({SchemaStore deletingScreen}) {
    executed = true;
    screensStore.deleteScreen(deletingScreen);
    deletedScreen = deletingScreen;
  }

  @override
  void redo() {}

  @override
  void undo() {
    if (!executed) return;
    screensStore.createScreen(deletedScreen);
  }
}
