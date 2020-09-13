import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/utils/Debouncer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SchemaNodeButton extends SchemaNode {
  Debouncer<String> textDebouncer;

  SchemaNodeButton({
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
    UniqueKey id,
  }) : super() {
    this.type = SchemaNodeType.button;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(150.0, 100.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', 'main')};
    this.properties = properties ??
        {
          'Text': SchemaStringProperty('Text', 'Button'),
          'Background': SchemaColorProperty('Background', Colors.indigo)
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
    return SchemaNodeButton(
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
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.tealAccent)),
      child: Center(child: Text(properties['Text'].value)),
    );
  }

  @override
  Widget toEditProps(userActions) {
    return Observer(
      builder: (_) => Column(children: [
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
      ]),
    );
  }
}
