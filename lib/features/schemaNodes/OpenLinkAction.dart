// ignore: avoid_web_libraries_in_flutter
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyTextField.dart';

import 'lists/ListItem.dart';

class OpenLinkAction extends SchemaNodeProperty<String>
    implements Functionable {
  OpenLinkAction(String name, String value) : super(name, value) {
    this.type = SchemaActionType.openLink;
    this.name = name;
    this.value = value;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'OpenLinkAction',
      'action': this.name,
      'type': this.type.toString(),
      'value': this.value == null ? null : this.value
    };
  }

  Function toFunction(UserActions userActions) {
    return ([Map<String, ListItem> rowData]) {
      _launchUrl();
    };
  }

  _launchUrl() async {
    final url = this.value;
    launch(url);
  }

  @override
  OpenLinkAction copy() {
    return OpenLinkAction(this.name, value);
  }

  @override
  SchemaActionType type;

  OpenLinkAction.fromJson(Map<String, dynamic> jsonVal) : super('Prop', null) {
    this.name = jsonVal['action'];
    this.type = SchemaActionType.openLink;
    this.value = jsonVal['value'];
  }

  @override
  Widget toEditProps(UserActions userActions) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 59,
              child: Text(
                'Link to',
                style: MyTextStyle.regularCaption,
              ),
            ),
            Expanded(
              child: MyTextField(
                key: userActions.selectedNode().id,
                placeholder: 'https://producthunt.com',
                defaultValue: this.value,
                onChanged: (newText) {
                  this.value = newText;
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
