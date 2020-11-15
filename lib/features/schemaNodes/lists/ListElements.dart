import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/RenderWithSelected.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/implementations.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
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

  SchemaListElementsProperty.fromJson(Map<String, dynamic> jsonVal)
      : super('Elements', null) {
    this.name = jsonVal['name'];
    this.value = ListElements(List<String>.from(jsonVal['value']['allColumns']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'propertyClass': 'ListElementsProperty',
      'value': {
        'allColumns': '',//value?.allColumns
      }
    };
  }

  @override
  SchemaListElementsProperty copy() {
    return SchemaListElementsProperty(this.name, value);
  }
}

typedef WrapFunction = Widget Function(Widget);

typedef GetPageWrapFunction = WrapFunction Function(String);

class ListElements {
  List<ListElementNode> listElements = [];
  List<String> allColumns;

  ListElements(List<String> allColumns) : this.allColumns = allColumns ?? [];

  _buildOptionPreview(String iconPath) {
    return Container(
      width: 18,
      height: 18,
      child: Image.network(iconPath),
    );
  }

  Map<UniqueKey, BuildWidgetFunction> getSettingsPagesBuildFunctions({GetPageWrapFunction getPageWrapFunction}) {
    Map<UniqueKey, BuildWidgetFunction> pages = {};

    this.listElements.forEach(
      (ListElementNode elementNode) {
        pages[elementNode.id] = () => elementNode.buildWidgetToEditProps(getPageWrapFunction(elementNode.name), allColumns);
      },
    );

    return pages;
  }

  Function(SchemaNodeProperty, [bool, dynamic]) getChangePropertyToFn(UniqueKey listElementNodeId, Function onListElementsUpdate) {
    return (SchemaNodeProperty changedProperty, [bool, dynamic]) {
      listElements.firstWhere((ListElementNode listElementNode) => listElementNode.id == listElementNodeId)
          .node.properties[changedProperty.name] = changedProperty;
      onListElementsUpdate();
    };
  }

  Widget toEditProps({
    SchemaNodeList schemaNodeList,
    Function onNodeSettingsClick,
    Function onListElementsUpdate,
  }) {
    final UserActions userActions = schemaNodeList.parent.userActions;

    return Column(
      children: [
        MyClickSelect(
          selectedValue: null,
          dropDownOnLeftSide: true,
          options: [
            SelectOption('Button', userActions.schemaNodeSpawner.spawnSchemaNodeButton, _buildOptionPreview('assets/icons/layout/button.svg')),
            SelectOption('Text', userActions.schemaNodeSpawner.spawnSchemaNodeText, _buildOptionPreview('assets/icons/layout/text.svg')),
            SelectOption('Shape', userActions.schemaNodeSpawner.spawnSchemaNodeShape, _buildOptionPreview('assets/icons/layout/shape.svg')),
            SelectOption('Icon', userActions.schemaNodeSpawner.spawnSchemaNodeIcon, _buildOptionPreview('assets/icons/layout/icon.svg')),
            SelectOption('Image', userActions.schemaNodeSpawner.spawnSchemaNodeImage, _buildOptionPreview('assets/icons/layout/image.svg')),
          ],
          onChange: (SelectOption option) {
            final SchemaNode node = option.value(
              // list padding horizontal - 12. todo: refac
              size: Offset(schemaNodeList.size.dx - 12 * 2, 30),
            );

            final ListElementNode createdNode = ListElementNode(
              id: node.id,
              node: node,
              name: option.name,
              iconPreview: option.leftWidget,
              changePropertyTo: getChangePropertyToFn(node.id, () => onListElementsUpdate()),
              onColumnRelationChange: onListElementsUpdate,
            );

            listElements.add(createdNode);
            onListElementsUpdate();
            onNodeSettingsClick(createdNode.id);
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
  final Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo;
  final Widget iconPreview;
  final Function onColumnRelationChange;

  Offset offsetFromRealScreen;

  String columnRelation;

  ListElementNode({
    Key key,
    @required this.node,
    @required this.iconPreview,
    @required this.name,
    @required this.id,
    @required this.changePropertyTo,
    @required this.onColumnRelationChange,
  });

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
          onNodeSettingsClick(this.id);
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
                      this.onColumnRelationChange();
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
            node.toEditProps((e) => e, onPropertyChanged),
          ],
        )
      );
    }

    return node.toEditProps(wrapInRoot, this.changePropertyTo);
  }

  void onPropertyChanged(SchemaNodeProperty changedProperty, [bool, dynamic]) {
    if (changedProperty.name == 'Text' || changedProperty.name == 'Url') {
      this.columnRelation = null;
    }

    this.changePropertyTo(changedProperty);
  }

  void repositionAndResize(node, { isAddedToDoneActions }) {
    this.node = node;
    this.onColumnRelationChange();
  }

  Widget toWidget({
    @required SchemaNodeList schemaNodeList,
    @required bool isPlayMode,
    @required Offset padding,
  }) {
      return GestureDetector(
          onTap: () {
            schemaNodeList.selectedListElementNode = this;
            this.onColumnRelationChange();
          },
          child: renderWithSelected(
            node: node,
            onPanEnd: (_) => {},
            repositionAndResize: this.repositionAndResize,
            currentScreenWorkspaceSize: Offset(
              schemaNodeList.size.dx - padding.dx * 2,
              schemaNodeList.properties['ListItemHeight'].value - padding.dy * 2,
            ),
            isPlayMode: isPlayMode,
            isSelected: schemaNodeList.selectedListElementNode?.id == this.id,
            toWidgetFunction: this.node.toWidget,
            isMagnetInteraction: false,
          )
      );
  }

  Widget toWidgetWithReplacedData({
    @required String data,
    @required SchemaNodeList schemaNodeList,
    @required bool isPlayMode,
    @required Offset padding,
  }) {
    return GestureDetector(
        onTap: () {
          schemaNodeList.selectedListElementNode = this;
          this.onColumnRelationChange();
        },
        child: renderWithSelected(
          node: node,
          onPanEnd: (_) => {},
          repositionAndResize: this.repositionAndResize,
          currentScreenWorkspaceSize: Offset(
            schemaNodeList.size.dx - padding.dx * 2,
            schemaNodeList.properties['ListItemHeight'].value - padding.dy * 2,
          ),
          isPlayMode: isPlayMode,
          isSelected: schemaNodeList.selectedListElementNode?.id == this.id,
          toWidgetFunction: ({ bool isPlayMode }) => (this.node as DataContainer).toWidgetWithReplacedData(data: data, isPlayMode: isPlayMode),
          isMagnetInteraction: false,
        )
    );
  }
}