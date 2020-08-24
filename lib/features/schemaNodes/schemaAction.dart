enum SchemaActionType { goToScreen }

abstract class SchemaAction {
  SchemaActionType type;
}

class GoToScreenAction extends SchemaAction {
  GoToScreenAction() : super() {
    this.type = SchemaActionType.goToScreen;
  }
}
