import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';

class BuildToolboxAirtablePage extends StatefulWidget {
  final Function goBackToSettings;
  final UserActions userActions;

  BuildToolboxAirtablePage({
    @required this.goBackToSettings,
    @required this.userActions,
  });
  @override
  _BuildToolboxAirtablePageState createState() =>
      _BuildToolboxAirtablePageState();
}

class _BuildToolboxAirtablePageState extends State<BuildToolboxAirtablePage> {
  Widget _buildItem({
    String title,
    String subtitle,
    String textFieldDefaultValue,
    Function onTextFieldChange,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: MyTextStyle.mediumTitle),
        SizedBox(height: 7.0),
        MyTextField(
          defaultValue: textFieldDefaultValue,
          onChanged: onTextFieldChange,
          disabled: true,
        ),
        SizedBox(height: 9.0),
        Text(subtitle, style: MyTextStyle.regularCaption),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToolboxHeader(
          leftWidget: IconCircleButton(
            onTap: widget.goBackToSettings,
            assetPath: 'assets/icons/meta/btn-back.svg',
          ),
          title: 'Airtable',
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.0, left: 20, right: 20),
          child: Container(
            child: Column(
              children: [
                _buildItem(
                  title: 'API Key',
                  subtitle:
                      'Please note that API key is for access to all your tables: it adds automatically to every new project you create',
                  textFieldDefaultValue: 'Your API Key',
                  onTextFieldChange: () {},
                ),
                SizedBox(height: 25.0),
                _buildItem(
                  title: 'Link to Your Base',
                  subtitle:
                      'This link is used only for this project. The base on this link should contain only data you will use in this app',
                  textFieldDefaultValue: 'Your Base',
                  onTextFieldChange: () {},
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
