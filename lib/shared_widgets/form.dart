import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/shared_widgets/button.dart' as Shared;
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/MyTextField.dart';

void emptyFunc(Map<String, dynamic> data) {}

class Form extends StatefulWidget {
  const Form(
      {Key key,
      this.theme,
      this.size,
      this.properties,
      this.isInputsDisabled = false,
      this.onCreate = emptyFunc})
      : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final Offset size;
  final MyTheme theme;
  final bool isInputsDisabled;
  final Function(Map<String, dynamic>) onCreate;

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  Map<String, dynamic> formState;

  @override
  void initState() {
    formState = {};

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedColumns = widget.properties['SelectedColumns'].value;

    return Container(
        width: widget.size.dx,
        height: widget.size.dy,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              ...selectedColumns.map((column) => Padding(
                    padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: widget.properties['ListItemPadding'].value),
                    child: Container(
                      height: 50,
                      child: MyTextField(
                        placeholder: column,
                        disabled: widget.isInputsDisabled,
                        maxLines: 1,
                        onChanged: (value) {
                          setState(() {
                            formState[column] = value;
                          });
                        },
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  widget.onCreate(formState);
                },
                child: Shared.Button(
                  properties: widget.properties,
                  theme: widget.theme,
                  size: Offset(widget.size.dx - 40.0, 50.0),
                ),
              )
            ],
          ),
        ));
  }
}
