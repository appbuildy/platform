import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/HoverOpacity.dart';
import 'package:flutter_app/ui/IFrame/IFrame.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyModal.dart';
import 'package:flutter_app/utils/StringExtentions/CapitalizeString.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ToolboxLayout extends StatelessWidget {
  final UserActions userActions;

  const ToolboxLayout({Key key, this.userActions}) : super(key: key);

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 11.0),
      child: Text(title, style: MyTextStyle.regularTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MyModal modal = MyModal();

    return Container(
      width: toolboxWidth,
      height: MediaQuery.of(context).size.height,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Observer(builder: (BuildContext context) {
                  return ToolboxTitle('Components');
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
                            schemaNode: userActions.schemaNodeSpawner
                                .spawnSchemaNodeButton(),
                          ),
                          ToolboxComponent(
                            schemaNode: userActions.schemaNodeSpawner
                                .spawnSchemaNodeText(),
                          ),
                          ToolboxComponent(
                            schemaNode: userActions.schemaNodeSpawner
                                .spawnSchemaNodeIcon(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ToolboxComponent(
                              schemaNode: userActions.schemaNodeSpawner
                                  .spawnSchemaNodeImage()),
                          SizedBox(
                            width: 10,
                          ),
                          ToolboxComponent(
                            schemaNode: userActions.schemaNodeSpawner
                                .spawnSchemaNodeShape(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      ToolBoxCaption('Lists'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ToolboxComponent(
                            defaultTitle: 'Compact',
                            iconPath: 'assets/icons/layout/listCompact.svg',
                            defaultType: SchemaNodeType.list,
                            schemaNode: userActions.schemaNodeSpawner
                                .spawnSchemaNodeListWithTemplate(
                                    listTemplateType: ListTemplateType.simple,
                                    listTemplateStyle:
                                        ListTemplateStyle.compact),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ToolboxComponent(
                            defaultTitle: 'Basic',
                            iconPath: 'assets/icons/layout/listBasic.svg',
                            defaultType: SchemaNodeType.list,
                            schemaNode: userActions.schemaNodeSpawner
                                .spawnSchemaNodeListWithTemplate(
                              listTemplateType: ListTemplateType.simple,
                              listTemplateStyle: ListTemplateStyle.basic,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ToolboxComponent(
                              defaultTitle: 'Tiles',
                              iconPath: 'assets/icons/layout/listTiles.svg',
                              defaultType: SchemaNodeType.list,
                              schemaNode: userActions.schemaNodeSpawner
                                  .spawnSchemaNodeListWithTemplate(
                                listTemplateType: ListTemplateType.cards,
                                listTemplateStyle: ListTemplateStyle.tiles,
                              ))
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ToolboxComponent(
                              defaultTitle: 'Cards',
                              iconPath: 'assets/icons/layout/listCards.svg',
                              defaultType: SchemaNodeType.list,
                              schemaNode: userActions.schemaNodeSpawner
                                  .spawnSchemaNodeListWithTemplate(
                                      listTemplateType: ListTemplateType.cards,
                                      listTemplateStyle:
                                          ListTemplateStyle.cards),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ToolboxComponent(
                              defaultTitle: 'Horizontal',
                              iconPath:
                                  'assets/icons/layout/listHorizontal.svg',
                              defaultType: SchemaNodeType.list,
                              schemaNode: userActions.schemaNodeSpawner
                                  .spawnSchemaNodeListWithTemplate(
                                      listTemplateType:
                                          ListTemplateType.horizontal,
                                      listTemplateStyle:
                                          ListTemplateStyle.tiles),
                            ),
                          ]),
                      ToolBoxCaption('Other'),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ToolboxComponent(
                              schemaNode: userActions.schemaNodeSpawner
                                  .spawnSchemaNodeForm(),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ToolboxComponent(
                              schemaNode: userActions.schemaNodeSpawner
                                  .spawnSchemaNodeMap(),
                            ),
                          ])
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: Container(
                width: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.centerEnd,
                    end: AlignmentDirectional.centerStart,
                    colors: [Color(0xFF00b1ff), Color(0xFF0083ff)],
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Image.network(
                            'assets/icons/meta/request-feature.svg')),
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, top: 13, left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Need a Feature?',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: MyColors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('We ll make it live — tell us about it',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: MyColors.white,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 12,
                            ),
                            Cursor(
                              cursor: CursorEnum.pointer,
                              child: GestureDetector(
                                onTap: () {
                                  modal.show(
                                      context: context,
                                      child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 20,
                                              right: 0,
                                            ),
                                            child: IFrame(
                                              key: UniqueKey(),
                                              src:
                                                  'https://www.appbuildy.com/upvoty',
                                            ),
                                          )),
                                      onClose: () {
                                        print('kekmek');
                                      });
                                },
                                child: HoverOpacity(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: MyColors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5,
                                              spreadRadius: 0,
                                              offset: Offset(0, 2),
                                              color: MyColors.black
                                                  .withOpacity(0.2))
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4,
                                          bottom: 6,
                                          left: 12,
                                          right: 12),
                                      child: Text('Request Feature',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: MyColors.textBlue,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ToolboxComponent extends StatelessWidget {
  final SchemaNode schemaNode;
  final String defaultTitle;
  final SchemaNodeType defaultType;
  final String iconPath;

  const ToolboxComponent(
      {Key key,
      this.defaultType,
      this.schemaNode,
      this.defaultTitle,
      this.iconPath = null})
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
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    iconPath ?? 'assets/icons/layout/$type.svg',
                  ),
                  Text(name),
                ],
              ),
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
