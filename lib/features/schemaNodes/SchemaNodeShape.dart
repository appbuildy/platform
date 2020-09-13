import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

class SchemaNodeShape extends SchemaNode {
  SchemaNodeShape({
    Offset position,
    Offset size,
    MyTheme theme,
    Map<String, SchemaNodeProperty> properties,
    UniqueKey id,
  }) : super() {
    this.type = SchemaNodeType.shape;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(150.0, 100.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', 'main')};
    this.properties =
        properties ?? {'Color': SchemaColorProperty('Color', Colors.red)};
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return SchemaNodeShape(
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
      color: properties['Color'].value,
    );
  }

  @override
  Widget toEditProps(userActions) {
    return Row(children: [
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
    ]);
  }
}
