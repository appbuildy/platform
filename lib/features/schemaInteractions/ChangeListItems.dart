import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';

class ChangeListItems {
  UserActions _userActions;
  ChangeListItems(this._userActions);

  void change(
      {SchemaStringListProperty list, String itemKey, String newValue}) {
    //final newList = list.copy();
    list.value[itemKey] = SchemaListItemProperty(
        itemKey, {'Text': SchemaStringProperty('Text', newValue)});
    _userActions.changePropertyTo(list);
  }
}
