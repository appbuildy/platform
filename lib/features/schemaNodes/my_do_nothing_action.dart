import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

import 'Functionable.dart';

class MyDoNothingAction extends SchemaNodeProperty implements Functionable {
  MyDoNothingAction() : super('', 'myDoNothingAction') {
    this.type = SchemaActionType.doNothing;
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'myDoNothingAction',
      'action': this.name,
      'type': this.type.toString(),
      'value': null
    };
  }

  Function toFunction(UserActions userActions) {
    return () {};
  }

  @override
  SchemaNodeProperty copy() {
    return MyDoNothingAction();
  }

  @override
  SchemaActionType type;
}
