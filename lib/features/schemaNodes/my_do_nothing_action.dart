import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

import 'Functionable.dart';

class MyDoNothingAction extends SchemaNodeProperty implements Functionable {
  MyDoNothingAction()
      : type = SchemaActionType.doNothing,
        super(
          name: '',
          value: 'myDoNothingAction',
        );

  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'myDoNothingAction',
      'action': this.name,
      'type': this.type.toString(),
      'value': null
    };
  }

  Function toFunction(UserAction userActions) {
    return () {};
  }

  @override
  SchemaNodeProperty copy() {
    return MyDoNothingAction();
  }

  @override
  SchemaActionType type;
}
