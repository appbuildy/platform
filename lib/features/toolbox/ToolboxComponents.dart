import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyColors.dart';

class ToolboxLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ToolboxComponent(
                schemaNode: SchemaNodeButton(),
              ),
              ToolboxComponent(schemaNode: SchemaNodeText()),
              ToolboxComponent(schemaNode: SchemaNodeShape())
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ToolboxComponent(schemaNode: SchemaNodeShape())],
          ),
        ],
      ),
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
    return Cursor(
      cursor: CursorEnum.pointer,
      child: Draggable<SchemaNode>(
        data: schemaNode,
        feedback: Material(child: Opacity(opacity: 0.5, child: child)),
        childWhenDragging: Opacity(opacity: 0.5, child: child),
        child: Padding(
          padding: const EdgeInsets.only(right: 11.0, bottom: 11.0),
          child: Container(
              height: 86,
              width: 86,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 1, color: MyColors.gray)),
              child: child),
        ),
      ),
    );
  }
}
