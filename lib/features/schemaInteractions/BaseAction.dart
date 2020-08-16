abstract class BaseAction {
  bool executed;

  void execute();
  void undo();
  void redo();
}
