import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/CapitalizeString.dart';

class ToolboxLayout extends StatelessWidget {
  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 11.0),
      child: Text(title, style: MyTextStyle.regularTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: toolboxWidth,
      child: Column(
        children: [
          ToolboxTitle(
            'Layout',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: Column(
              children: [
                ToolBoxCaption('Basics'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ToolboxComponent(
                      schemaNode: SchemaNodeButton(),
                    ),
                    ToolboxComponent(schemaNode: SchemaNodeText()),
                    ToolboxComponent(schemaNode: SchemaNodeImage()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ToolboxComponent(schemaNode: SchemaNodeShape())],
                ),
                ToolBoxCaption('Listing'),
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
                  children: [
                    ToolboxComponent(schemaNode: SchemaNodeShape()),
                    ToolboxComponent(schemaNode: SchemaNodeText()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ToolboxComponent extends StatelessWidget {
  final SchemaNode schemaNode;

  const ToolboxComponent({Key key, this.schemaNode}) : super(key: key);

  Widget buildComponent() {
    final defaultDecoration = BoxDecoration(
        gradient: MyGradients.plainWhite,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: MyColors.gray));

    final hoverDecoration = BoxDecoration(
      gradient: MyGradients.lightBlue,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(width: 1, color: MyColors.mainBlue),
    );

    final type = schemaNode.type.toString().split('.')[1];
    final name = type.capitalize();

    return Cursor(
      cursor: CursorEnum.pointer,
      child: Container(
          height: 86,
          width: 86,
          child: HoverDecoration(
            defaultDecoration: defaultDecoration,
            hoverDecoration: hoverDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.network(
                  'assets/icons/layout/$type.svg',
                  height: 56.0,
                ),
                Text(name),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final component = buildComponent();

    return Draggable<SchemaNode>(
      data: schemaNode,
      feedback: Material(
          borderRadius: BorderRadius.circular(6),
          child: Opacity(opacity: 0.5, child: component)),
      childWhenDragging: Opacity(
          opacity: 0.5,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 11.0),
            child: component,
          )),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 11.0),
        child: component,
      ),
    );
  }
}
