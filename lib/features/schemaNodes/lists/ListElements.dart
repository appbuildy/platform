import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_app/features/schemaNodes/implementations.dart';
import 'package:flutter_app/features/services/project_load/ComponentLoadedFromJson.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/SelectOption.dart';
import 'package:flutter_app/ui/PageSliderAnimator.dart';

import '../SchemaNode.dart';
import '../SchemaNodeList.dart';
import '../SchemaNodeProperty.dart';

class SchemaListElementsProperty extends SchemaNodeProperty<ListElements> {
  SchemaListElementsProperty(String name, ListElements value) : super(name, value);

  SchemaListElementsProperty.fromJson(
      Map<String, dynamic> jsonVal,
      SchemaNodeSpawner schemaNodeSpawner,
    )
      : super('Elements', null) {
    this.name = jsonVal['name'];

    //print(jsonDecode(jsonVal['value']['listElements']));
    //print(jsonVal['value']['listElements'].runtimeType);
    //print(jsonVal['value']['listElements']);

    print('eboi');
    List<dynamic>.from(jsonVal['value']['listElements']).map((e) {
      print('eboi');
      print(e);
      return this.value.fromJsonListElementNode(e, schemaNodeSpawner);
    });
    print('eboi');

    this.value = ListElements(
      allColumns: List<String>.from(jsonDecode(jsonVal['value']['allColumns'])),
      //listElements: ,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'propertyClass': 'ListElementsProperty',
      'value': {
        'allColumns': jsonEncode(this.value.allColumns),
        'listElements': this.value.listElements
          .map((ListElementNode listElementNode) => this.value.toJsonListElementNode(listElementNode))
          .toList()
          .cast<Map<String, dynamic>>(),
      }
    };
  }

  @override
  SchemaListElementsProperty copy() {
    return SchemaListElementsProperty(this.name, value);
  }
}

typedef WrapFunction = Widget Function(Widget);

typedef GetPageWrapFunction = WrapFunction Function(ListElementNode);

String getNodeIconPath(String nodeType) {
  switch (nodeType) {
    case 'SchemaNodeType.icon':
      return 'assets/icons/layout/icon.svg';
    case 'SchemaNodeType.button':
      return 'assets/icons/layout/button.svg';
    case 'SchemaNodeType.text':
      return 'assets/icons/layout/text.svg';
    case 'SchemaNodeType.shape':
      return 'assets/icons/layout/shape.svg';
    case 'SchemaNodeType.image':
      return 'assets/icons/layout/image.svg';
    default:
      return 'assets/icons/layout/button.svg';
  }
}

Function getSpawnFunction({ SchemaNodeSpawner schemaNodeSpawner, nodeType }) {
  switch (nodeType) {
    case 'SchemaNodeType.icon':
      return schemaNodeSpawner.spawnSchemaNodeIcon;
    case 'SchemaNodeType.button':
      return schemaNodeSpawner.spawnSchemaNodeButton;
    case 'SchemaNodeType.text':
      return schemaNodeSpawner.spawnSchemaNodeText;
    case 'SchemaNodeType.shape':
      return schemaNodeSpawner.spawnSchemaNodeShape;
    case 'SchemaNodeType.image':
      return schemaNodeSpawner.spawnSchemaNodeImage;
    default:
      return schemaNodeSpawner.spawnSchemaNodeButton;
  }
}

class ListElements {
  List<ListElementNode> listElements = [];
  List<String> allColumns = [];

  ListElements({allColumns, listElements}) : this.allColumns = allColumns ?? [], this.listElements = listElements ?? [];

  _buildOptionPreview(String nodeType) {
    return Container(
      width: 18,
      height: 18,
      child: Image.network(getNodeIconPath(nodeType)),
    );
  }

  Map<UniqueKey, BuildWidgetFunction> getSettingsPagesBuildFunctions({GetPageWrapFunction getPageWrapFunction}) {
    Map<UniqueKey, BuildWidgetFunction> pages = {};

    this.listElements.forEach(
      (ListElementNode elementNode) {
        pages[elementNode.id] = () => elementNode.buildWidgetToEditProps(getPageWrapFunction(elementNode), allColumns);
      },
    );

    return pages;
  }

  void changePropertyTo(SchemaNodeProperty changedProperty, UniqueKey listElementNodeId, Function onListElementsUpdate) {
    listElements.firstWhere((ListElementNode listElementNode) => listElementNode.id == listElementNodeId)
        .node.properties[changedProperty.name] = changedProperty;
    onListElementsUpdate();
  }

  ListElementNode copyListElementNode({ListElementNode listElementNode, Function selectListElementNode}) {
    final ListElementNode copy = listElementNode.copy();

    this.listElements.add(copy);

    return copy;
  }

  void bringToFrontListElementNode({ListElementNode listElementNode}) {
    this.listElements.removeWhere((element) => element.id == listElementNode.id);

    this.listElements.add(listElementNode);

    listElementNode.onListElementsUpdate();
  }

  void sendToBackListElementNode({ListElementNode listElementNode}) {
    this.listElements.removeWhere((element) => element.id == listElementNode.id);

    this.listElements.insert(0, listElementNode);

    listElementNode.onListElementsUpdate();
  }

  void deleteListElementNode({ ListElementNode listElementNode }) {
    this.listElements.remove(listElementNode);
  }

  Map<String, dynamic> toJsonListElementNode(ListElementNode listElementNode) {
    final Map<String, dynamic> jsonSchemaNode = listElementNode.node.toJson();

    return {
      'name': listElementNode.name,
      'columnRelation': listElementNode.columnRelation,
      'type': jsonSchemaNode['type'],
      'node': jsonSchemaNode,
    };
  }

  ListElementNode fromJsonListElementNode(Map<String, dynamic> jsonListElement, SchemaNodeSpawner schemaNodeSpawner) {
    final SchemaNode deserializedNode = ComponentLoadedFromJson(jsonComponent: jsonListElement['node'] , schemaNodeSpawner: schemaNodeSpawner).load();

    return ListElementNode(
        node: deserializedNode,
        iconPreview: _buildOptionPreview(jsonListElement['type']),
        name: jsonListElement['name'],
        id: deserializedNode.id,
        changePropertyTo: this.changePropertyTo,
        onListElementsUpdate: () {},
    );
  }

  Widget toEditProps({
    SchemaNodeList schemaNodeList,
    Function onNodeSettingsClick,
    Function onListElementsUpdate,
  }) {
    final UserActions userActions = schemaNodeList.parentSpawner.userActions;

    this.listElements.forEach((element) { element.onListElementsUpdate = onListElementsUpdate; });

    return Column(
      children: [
        MyClickSelect(
          selectedValue: null,
          dropDownOnLeftSide: true,
          options: [
            SelectOption('Button', userActions.schemaNodeSpawner.spawnSchemaNodeButton, _buildOptionPreview('SchemaNodeType.button')),
            SelectOption('Text', userActions.schemaNodeSpawner.spawnSchemaNodeText, _buildOptionPreview('SchemaNodeType.text')),
            SelectOption('Shape', userActions.schemaNodeSpawner.spawnSchemaNodeShape, _buildOptionPreview('SchemaNodeType.shape')),
            SelectOption('Icon', userActions.schemaNodeSpawner.spawnSchemaNodeIcon, _buildOptionPreview('SchemaNodeType.icon')),
            SelectOption('Image', userActions.schemaNodeSpawner.spawnSchemaNodeImage, _buildOptionPreview('SchemaNodeType.image')),
          ],
          onChange: (SelectOption option) {
            final SchemaNode node = option.value(
              size: Offset(schemaNodeList.listElementNodeWorkspaceSize.dx, 30),
            );

            final ListElementNode createdNode = ListElementNode(
              id: node.id,
              node: node,
              name: option.name,
              iconPreview: option.leftWidget,
              changePropertyTo: this.changePropertyTo,
              onListElementsUpdate: onListElementsUpdate,
            );

            listElements.add(createdNode);

            onListElementsUpdate();

            // todo: refac. Без асинхронности не закрывается MyClickSelect;
            Future.delayed(Duration(milliseconds: 0), () => onNodeSettingsClick(createdNode));
          },
          defaultPreview: MyButtonUI(
            text: 'Add Element',
            icon: Image.network('assets/icons/meta/btn-plus.svg'),
          ),
        ),
        ...listElements.map((ListElementNode element) => Column(
          children: [
            SizedBox(height: 8),
            element.buildSettingsButton(onNodeSettingsClick),
          ],
        )),
      ],
    );
  }
}

class ListElementNode {
  SchemaNode node;

  final String name;
  final UniqueKey id;
  final Function(SchemaNodeProperty, UniqueKey, Function) changePropertyTo;
  final Widget iconPreview;

  Function onListElementsUpdate;
  String columnRelation;

  ListElementNode({
    Key key,
    @required this.node,
    @required this.iconPreview,
    @required this.name,
    @required this.id,
    @required this.changePropertyTo,
    @required this.onListElementsUpdate,
    this.columnRelation = null,
  });

  ListElementNode copy() {
    final SchemaNode nodeCopy = this.node.copy(id: UniqueKey(), saveProperties: true);

    return ListElementNode(
      node: nodeCopy,
      iconPreview: this.iconPreview,
      name: this.name,
      id: nodeCopy.id,
      changePropertyTo: this.changePropertyTo,
      onListElementsUpdate: this.onListElementsUpdate,
      columnRelation: this.columnRelation,
    );
  }

  Widget buildSettingsButton(Function onNodeSettingsClick) {
    BoxDecoration defaultDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      gradient: MyGradients.buttonLightGray,
      border: Border.all(width: 1, color: MyColors.borderGray),
    );

    BoxDecoration hoverDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      gradient: MyGradients.buttonLightBlue,
      border: Border.all(width: 1, color: MyColors.borderGray),
    );

    return Cursor(
      cursor: CursorEnum.pointer,
      child: GestureDetector(
        onTap: () {
          onNodeSettingsClick(this);
        },
        child: HoverDecoration(
          defaultDecoration: defaultDecoration,
          hoverDecoration: hoverDecoration,
          child: Container(
            height: 36.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: this.iconPreview,
                  ),
                  Text(
                    this.name,
                    style: MyTextStyle.regularTitle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWidgetToEditProps(Function wrapInRoot, List<String> allColumns) {
    if (node is DataContainer) {
      return wrapInRoot(
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 58,
                  child: Text(
                    'Data',
                    style: MyTextStyle.regularCaption,
                  ),
                ),
                Expanded(
                  child: MyClickSelect(
                    selectedValue: this.columnRelation,
                    options: [
                      SelectOption('Select option', null),
                      ...allColumns.map((String column) => SelectOption(column, column)).toList(),
                    ],
                    onChange: (SelectOption pickedColumn) {
                      this.columnRelation = pickedColumn.value;
                      this.onListElementsUpdate();
                    },
                    placeholder: 'Select column',
                    defaultIcon: Container(
                      child: Image.network(
                        'assets/icons/meta/btn-detailed-info-big.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            node.toEditProps((e) => e, this.onPropertyChanged),
          ],
        )
      );
    }

    return node.toEditProps(wrapInRoot, this.onPropertyChanged);
  }

  void onPropertyChanged(SchemaNodeProperty changedProperty, [bool, dynamic]) {
    if (changedProperty.name == 'Text' || changedProperty.name == 'Url') {
      this.columnRelation = null;
    }

    this.changePropertyTo(changedProperty, this.id, this.onListElementsUpdate);
  }

  void repositionAndResize(node, { isAddedToDoneActions }) {
    this.node = node;
    this.onListElementsUpdate();
  }

  void onUpOrDownPressed({bool isUp, Offset currentScreenWorkspaceSize}) {
    this.node.onUpOrDownPressed(isUp: isUp, currentScreenWorkspaceSize: currentScreenWorkspaceSize, repositionAndResize: this.repositionAndResize);
  }

  void onLeftOrRightPressed({bool isLeft, Offset currentScreenWorkspaceSize}) {
    this.node.onLeftOrRightPressed(isLeft: isLeft, currentScreenWorkspaceSize: currentScreenWorkspaceSize, repositionAndResize: this.repositionAndResize);
  }

  void onListLeftResize({double deltaDx, Offset currentScreenWorkspaceSize}) {
    this.node.move(delta: Offset(deltaDx, 0), screenSize: currentScreenWorkspaceSize);
    //todo: optimization this.onListElementUpdate();
    this.onListElementsUpdate();
  }

  Widget toWidget({
    @required SchemaNodeList schemaNodeList,
    @required bool isPlayMode,
  }) {
    if (!schemaNodeList.isSelected) {
      return this.node.toWidget(isPlayMode: isPlayMode);
    }

    return GestureDetector(
        onTap: () {
          schemaNodeList.selectListElementNode(this);
        },
        child: SchemaNode.renderWithSelected(
          node: node,
          onPanEnd: (_) => {},
          repositionAndResize: this.repositionAndResize,
          currentScreenWorkspaceSize: schemaNodeList.listElementNodeWorkspaceSize,
          isPlayMode: isPlayMode,
          isSelected: schemaNodeList.selectedListElementNode?.id == this.id,
          toWidgetFunction: this.node.toWidget,
          isMagnetInteraction: false,
          selectNodeForEdit: (_) {
            schemaNodeList.selectListElementNode(this);
          }
        )
    );
  }

  Widget toWidgetWithReplacedData({
    @required String data,
    @required SchemaNodeList schemaNodeList,
    @required bool isPlayMode,
  }) {
    if (!schemaNodeList.isSelected) {
      return (this.node as DataContainer).toWidgetWithReplacedData(data: data, isPlayMode: isPlayMode);
    }

    return GestureDetector(
        onTap: () {
          schemaNodeList.selectListElementNode(this);
        },
        child: SchemaNode.renderWithSelected(
          node: node,
          onPanEnd: (_) => {},
          repositionAndResize: this.repositionAndResize,
          currentScreenWorkspaceSize: schemaNodeList.listElementNodeWorkspaceSize,
          isPlayMode: isPlayMode,
          isSelected: schemaNodeList.selectedListElementNode?.id == this.id,
          toWidgetFunction: ({ bool isPlayMode }) => (this.node as DataContainer).toWidgetWithReplacedData(data: data, isPlayMode: isPlayMode),
          isMagnetInteraction: false,
          selectNodeForEdit: (_) {
            schemaNodeList.selectListElementNode(this);
          }
        )
    );
  }
}