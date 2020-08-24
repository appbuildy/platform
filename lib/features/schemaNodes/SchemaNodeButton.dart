import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SchemaNodeButton extends SchemaNode {
  SchemaNodeButton({
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaAction> actions,
    UniqueKey id,
  }) : super() {
    this.type = SchemaNodeType.button;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(150.0, 100.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {};
    this.properties = properties ??
        {
          'Text': SchemaStringProperty('Text', 'Button'),
          'Background': SchemaColorProperty('Background', Colors.indigo)
        };
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
        properties: properties ?? this.properties);
  }

  @override
  Widget toWidget() {
    return Container(
      width: size.dx,
      height: size.dy,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.tealAccent)),
      child: Center(
          child: Text(
              'position dx: ${position.dx.toString()} position dy: ${position.dy.toString()} size dx: ${size.dx.toString()} size dy: ${size.dy.toString()}')),
    );
  }

  @override
  Widget toEditProps(changePropTo) {
//    final debouncer = Debouncer(milliseconds: 700);

    return Observer(
      builder: (_) => Column(children: [
        Text(
          'Button Node',
        ),
        SizedBox(height: 16),
        Text('Value'),
        SizedBox(height: 8),
        MyTextField(
          key: id,
          defaultValue: properties['Text'].value,
          onChanged: (newText) {
            changePropTo(SchemaStringProperty('Text', newText));
//            debouncer
//                .run(() => changePropTo(SchemaStringProperty('Text', newText)));
          },
        ),
      ]),
    );
  }
}
