import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';

class ChangeListItems {
  UserAction _userActions;
  ChangeListItems(this._userActions);

  void change(
      {SchemaStringListProperty list, String itemKey, String newValue}) {
    //final newList = list.copy();
//    list.value[itemKey] = SchemaListItemProperty(  ЖЕКА ГЛЯНЬ ЭТУУ ШТКУКУ
//        itemKey, {'Text': SchemaStringProperty('Text', newValue)});
//    _userActions.changePropertyTo(list);
  }
}
