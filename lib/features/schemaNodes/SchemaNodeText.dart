import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/features/rightToolbox/RemoteAttributeSelect.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/utils/Debouncer.dart';

class SchemaNodeText extends SchemaNode {
  Debouncer<String> textDebouncer;

  SchemaNodeText(
      {Offset position,
      Offset size,
      Map<String, SchemaNodeProperty> properties,
      UniqueKey id})
      : super() {
    this.type = SchemaNodeType.text;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(150.0, 100.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', 'main')};
    this.properties = properties ??
        {
          'Text': SchemaStringProperty('Text', 'Text'),
          'Color': SchemaColorProperty('Color', Colors.black)
        };

    textDebouncer =
        Debouncer(milliseconds: 500, prevValue: this.properties['Text'].value);
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return SchemaNodeText(
        position: position ?? this.position,
        id: id ?? this.id,
        size: size ?? this.size,
        properties: saveProperties ? this._copyProperties() : null);
  }

  Map<String, SchemaNodeProperty> _copyProperties() {
    final newProps = Map<String, SchemaNodeProperty>();
    this.properties.forEach((key, value) {
      newProps[key] = value.copy();
    });

    return newProps;
  }

  @override
  Widget toWidget() {
    return Container(
      width: size.dx,
      height: size.dy,
      child: Text(
        properties['Text'].value,
        style: TextStyle(fontSize: 16.0, color: properties['Color'].value),
      ),
    );
  }

  @override
  Widget toEditProps(userActions) {
    log(userActions.remoteAttributeList().toString());
    return Column(children: [
      Text(
        'Text Node',
      ),
      SizedBox(height: 16),
      Text('Value'),
      SizedBox(height: 8),
      RemoteAttributesSelect(userActions: userActions),
      MyTextField(
        key: id,
        defaultValue: properties['Text'].value,
        onChanged: (newText) {
          userActions.changePropertyTo(
              SchemaStringProperty('Text', newText), false);

          textDebouncer.run(
              () => userActions.changePropertyTo(
                  SchemaStringProperty('Text', newText),
                  true,
                  textDebouncer.prevValue),
              newText);
        },
      ),
      SizedBox(height: 8),
      Row(
        children: [
          GestureDetector(
            onTap: () {
              userActions
                  .changePropertyTo(SchemaColorProperty('Color', Colors.black));
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              userActions
                  .changePropertyTo(SchemaColorProperty('Color', Colors.red));
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: Colors.red),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              userActions
                  .changePropertyTo(SchemaColorProperty('Color', Colors.blue));
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
          SizedBox(
            width: 8,
          ),
        ],
      ),
    ]);
  }
}
