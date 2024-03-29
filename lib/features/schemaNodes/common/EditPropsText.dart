import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/utils/Debouncer.dart';

class EditPropsText extends StatelessWidget {
  final UniqueKey id;
  final Map<String, SchemaNodeProperty> properties;
  final String propName;
  final String title;
  final String placeholder;
  //final UserActions userActions;
  final Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo;
  final Debouncer textDebouncer;

  const EditPropsText(
      {Key key,
      @required this.id,
      @required this.properties,
      @required this.propName,
      //@required this.userActions,
      @required this.changePropertyTo,
      this.title,
      this.placeholder,
      @required this.textDebouncer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 59,
          child: Text(
            title ?? 'Text',
            style: MyTextStyle.regularCaption,
          ),
        ),
        Expanded(
          child: MyTextField(
            key: id,
            placeholder: placeholder,
            disabled: properties['Column'] != null &&
                properties['Column'].value != null,
            defaultValue: properties[propName].value,
            onChanged: (newText) {
              changePropertyTo(SchemaStringProperty(propName, newText), false);
              textDebouncer.run(
                () => changePropertyTo(
                  SchemaStringProperty(propName, newText),
                  true,
                  textDebouncer.prevValue,
                ),
                newText,
              );
            },
          ),
        ),
      ],
    );
  }
}
