import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeIcon.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/StringExtentions/CapitalizeString.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ToolboxLayout extends StatelessWidget {
  final UserActions userActions;
  final CurrentUserStore currentUserStore;

  const ToolboxLayout({Key key, this.currentUserStore, this.userActions})
      : super(key: key);

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 11.0),
      child: Text(title, style: MyTextStyle.regularTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = userActions.theme;

    return Container(
      width: toolboxWidth,
      child: Column(
        children: [
          Observer(builder: (BuildContext context) {
            return ToolboxTitle(
              currentUserStore.currentUser.name,
            );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: Column(
              children: [
                ToolBoxCaption('Basics'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ToolboxComponent(
                      schemaNode: SchemaNodeButton(theme: theme),
                    ),
                    ToolboxComponent(schemaNode: SchemaNodeText(theme: theme)),
                    ToolboxComponent(schemaNode: SchemaNodeIcon(theme: theme)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ToolboxComponent(schemaNode: SchemaNodeImage()),
                    SizedBox(
                      width: 10,
                    ),
                    ToolboxComponent(schemaNode: SchemaNodeShape(theme: theme)),
                  ],
                ),
                ToolBoxCaption('Listing'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ToolboxComponent(
                        defaultTitle: 'List',
                        defaultType: SchemaNodeType.listDefault,
                        schemaNode: SchemaNodeList(
                          theme: theme,
                          listTemplateType: ListTemplateType.simple,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    ToolboxComponent(
                        defaultTitle: 'Cards',
                        defaultType: SchemaNodeType.listCards,
                        schemaNode: SchemaNodeList(
                            theme: theme,
                            listTemplateType: ListTemplateType.cards))
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
  final String defaultTitle;
  final SchemaNodeType defaultType;

  const ToolboxComponent(
      {Key key, this.defaultType, this.schemaNode, this.defaultTitle})
      : super(key: key);

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

    final realType = defaultType ?? schemaNode.type;
    final type = realType.toString().split('.')[1];
    final name =
        defaultTitle != null ? defaultTitle.capitalize() : type.capitalize();

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
          child: Opacity(
              opacity: 0.4, child: schemaNode.toWidget(isPlayMode: false))),
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
