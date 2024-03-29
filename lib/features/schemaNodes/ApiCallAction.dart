import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:http/http.dart' as http;

import 'lists/ListItem.dart';

class ApiCallAction extends SchemaNodeProperty<String> implements Functionable {
  ApiCallAction(String name, String value) : super(name, value) {
    this.type = SchemaActionType.apiCall;
    this.name = name;
    this.value = value;
    this.column = column;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'propertyClass': 'ApiCallAction',
      'action': this.name,
      'type': this.type.toString(),
      'value': this.value == null ? null : this.value,
      'column': this.column
    };
  }

  Function toFunction(UserActions userActions) {
    return ([Map<String, ListItem> rowData]) {
      http.get(this.value);
    };
  }

  @override
  ApiCallAction copy() {
    return ApiCallAction(this.name, value);
  }

  @override
  SchemaActionType type;

  @override
  String column;

  ApiCallAction.fromJson(Map<String, dynamic> jsonVal) : super('Prop', null) {
    this.name = jsonVal['action'];
    this.type = SchemaActionType.apiCall;
    this.value = jsonVal['value'];
    this.column = jsonVal['column'];
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
                'Url',
                style: MyTextStyle.regularCaption,
              ),
            ),
            Expanded(
              child: MyTextField(
                key: userActions.selectedNode().id,
                placeholder:
                    'https://hooks.zapier.com/hooks/catch/8579222/oc5n0se/',
                value: this.value,
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
