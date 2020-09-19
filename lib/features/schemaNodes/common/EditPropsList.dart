import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/utils/Debouncer.dart';

class EditPropsList extends StatelessWidget {
  final UniqueKey id;
  final Map<String, SchemaNodeProperty> properties;
  final String propName;
  final UserActions userActions;
  final Debouncer textDebouncer;

  const EditPropsList(
      {Key key,
      @required this.id,
      @required this.properties,
      @required this.propName,
      @required this.userActions,
      @required this.textDebouncer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            defaultValue: properties[propName].value.first.value,
            onChanged: (newText) {
              userActions.changePropertyTo(
                  SchemaStringListProperty(
                      propName, [SchemaStringProperty('item1', newText)]),
                  false);

              textDebouncer.run(
                  () => userActions.changePropertyTo(
                      SchemaStringListProperty(
                          propName, [SchemaStringProperty('item1', newText)]),
                      true,
                      textDebouncer.prevValue),
                  newText);
            },
          ),
        ),
      ],
    );
  }
}
