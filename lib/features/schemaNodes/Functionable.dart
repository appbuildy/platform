import 'package:flutter_app/features/schemaInteractions/UserActions.dart';

enum SchemaActionType { doNothing, goToScreen }

abstract class Functionable {
  SchemaActionType type;
  Function toFunction(
    UserActions userActions,
  );
}
