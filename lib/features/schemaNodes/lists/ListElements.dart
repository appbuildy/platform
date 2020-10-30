import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/MySwitch.dart';

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

  Widget toEditProps({
    UserActions userActions,
    AppThemeStore themeStore,
    Function onNodeSettingsClick,
    Function onListElementsUpdate,
  }) {
    return Column(
      children: [
        MyButton(
          text: 'Add Element',
          icon: Image.network('assets/icons/meta/btn-plus.svg'),
          onTap: () {
            listElements.add(ListElementNode(userActions: userActions, node: SchemaNodeButton(themeStore: themeStore), name: 'Button'));
            onListElementsUpdate(this);
          },
       ),
        ...listElements.map((ListElementNode element) => element.buildSettingsButton(onNodeSettingsClick)),
      ],
    );
  }

  ListElements({ this.allColumns });
}

class ListElementNode {
  //final ListElementType type;
  final SchemaNode node;
  final String name;
  final UniqueKey nodeId;
  final UserActions userActions;

  ListElementNode({
    Key key,
    @required this.node,
    //@required this.type,
    @required this.name,
    @required this.userActions,
  }) : this.nodeId = node.id;

  Widget buildSettingsButton(Function onNodeSettingsClick) {
    return Cursor(
      cursor: CursorEnum.pointer,
      child: GestureDetector(
        onTap: () {
          onNodeSettingsClick(this.nodeId);
        },
        child: Text(this.name),
      ),
    );
  }

  Widget buildWidgetToEditProps(Function wrapInRoot) {
    return node.toEditProps(this.userActions, wrapInRoot);
  }

  Widget buildWidget() {
    return node.toWidget(userActions: this.userActions);
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
