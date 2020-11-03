import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/SelectOption.dart';

import '../SchemaNode.dart';
import '../SchemaNodeProperty.dart';

class ListElementsProperty extends SchemaNodeProperty<ListElements> {
  ListElementsProperty(String name, ListElements value) : super(name, value);

  ListElementsProperty.fromJson(Map<String, dynamic> jsonVal)
      : super('Elements', null) {
    this.name = jsonVal['name'];
    this.value = ListElements(
        allColumns: List<String>.from(jsonVal['value']['allColumns']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'propertyClass': 'ListElementsProperty',
      'value': {
        'allColumns': value?.allColumns
      }
    };
  }

  @override
  ListElementsProperty copy() {
    return ListElementsProperty(this.name, value);
  }
}

class ListElements {
  List<String> allColumns;
  List<ListElementNode> listElements = [];

  _buildOptionPreview(String iconPath) {
    return Container(
      width: 18,
      height: 18,
      child: Image.network(iconPath),
    );
  }

  Widget toEditProps({
    UserActions userActions,
    Function onNodeSettingsClick,
    Function onListElementsUpdate,
  }) {
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
            listElements.add(
              ListElementNode(
                node: option.value(),
                name: option.name,
                iconPreview: option.leftWidget,
                userActions: userActions,
              )
            );
            onListElementsUpdate(this);
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
        ),
        ),
      ],
    );
  }

  ListElements({ this.allColumns });
}

class ListElementNode {
  final SchemaNode node;
  final String name;
  final UniqueKey nodeId;
  final UserActions userActions;
  final Widget iconPreview;

  ListElementNode({
    Key key,
    @required this.node,
    @required this.iconPreview,
    @required this.name,
    @required this.userActions,
  }) : this.nodeId = node.id;

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
          onNodeSettingsClick(this.nodeId);
        },
        child: Expanded(
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
      ),
    );
  }

  Widget buildWidgetToEditProps(Function wrapInRoot) {
    return node.toEditProps(wrapInRoot);
  }

  Widget buildWidget() {
    return node.toWidget();
  }
}


enum ListElementType { title, subtitle, image, navigationIcon }

class ListElement {
  String column;
  ListElementType type;

  ListElement({@required String column, @required ListElementType type}) {
    this.column = column;
    this.type = type;
  }

  ListElement.fromJson(Map<String, dynamic> jsonVar) {
    if (jsonVar == null) return;
    this.type = ListElementType.values
        .firstWhere((el) => el.toString() == jsonVar['type']);
    this.column = jsonVar['column'];
  }

  Map<String, dynamic> toJson() {
    return {'column': column, 'type': type.toString()};
  }
}
