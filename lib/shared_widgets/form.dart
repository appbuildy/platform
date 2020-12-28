import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/shared_widgets/button.dart' as Shared;
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/MyTextField.dart';

class Form extends StatelessWidget {
  const Form({Key key, this.theme, this.size, this.properties})
      : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final Offset size;
  final MyTheme theme;

  @override
  Widget build(BuildContext context) {
    final selectedColumns = properties['SelectedColumns'].value;
    return Container(
        width: size.dx,
        height: size.dy,
        child: Column(
          children: [
            ...selectedColumns.map((column) => Padding(
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: properties['ListItemPadding'].value),
                  child: MyTextField(
                    placeholder: column,
                    onChanged: () {},
                  ),
                )),
            Shared.Button(
              properties: properties,
              theme: theme,
              size: Offset(size.dx - 40.0, 50.0),
            )
          ],
        ));
  }
}
