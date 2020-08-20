import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/toolbox/components/ButtonComponent.dart';
import 'package:flutter_app/features/toolbox/components/ShapeComponent.dart';
import 'package:flutter_app/features/toolbox/components/TextComponent.dart';
import 'package:flutter_app/ui/Cursor.dart';

class ToolboxComponentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        ToolboxComponent(
          child: ToolboxButtonComponent(),
          schemaNode: SchemaNodeButton(),
        ),
        ToolboxComponent(
            child: ToolboxTextComponent(), schemaNode: SchemaNodeText()),
        ToolboxComponent(
            child: ToolboxShapeComponent(), schemaNode: SchemaNodeShape()),
      ],
    );
  }
}

class ToolboxComponent extends StatelessWidget {
  final Widget child;
  final SchemaNode schemaNode;

  const ToolboxComponent({Key key, this.child, this.schemaNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Cursor(
        cursor: CursorEnum.pointer,
        child: Draggable<SchemaNode>(
          data: schemaNode,
          feedback: Material(child: Opacity(opacity: 0.5, child: child)),
          childWhenDragging: Opacity(opacity: 0.5, child: child),
          child: child,
        ),
      ),
    );
  }
}
