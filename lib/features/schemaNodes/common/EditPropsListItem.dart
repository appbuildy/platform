import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/ChangeListItems.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/config/colors.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/utils/Debouncer.dart';

class EditPropsListItem extends StatelessWidget {
  final UniqueKey id;
  final Map<String, SchemaNodeProperty> properties;
  final String propName;
  final UserActions userActions;
  final Debouncer textDebouncer;
  final String listKey;

  const EditPropsListItem(
      {Key key,
      @required this.id,
      @required this.properties,
      @required this.propName,
      @required this.userActions,
      @required this.listKey,
      @required this.textDebouncer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = properties[propName].value;
    return Row(
      children: [
        Text(
          'Text',
          style: MyTextStyle.regularCaption,
        ),
        SizedBox(
          width: 31,
        ),
        Expanded(
          child: MyTextField(
            key: id,
            defaultValue:
                properties[propName].value[listKey].value['Text'].value,
            onChanged: (newText) {
              ChangeListItems(userActions).change(
                  list: properties[propName],
                  itemKey: listKey,
                  newValue: newText);
            },
          ),
        ),
      ],
    );
  }
}
