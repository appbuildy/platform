// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/GuidelinesManager/GuidelinesManager.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/ConnectAirtableModal.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListTemplateProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';
import 'package:flutter_app/ui/WithInfo.dart';
import 'package:flutter_app/utils/Debouncer.dart';
import 'package:flutter_app/ui/PageSliderAnimator.dart';

class EditPropsAnimation extends StatefulWidget {
  final BuildWidgetFunction rootPage;
  final Map<UniqueKey, BuildWidgetFunction> pages;

  EditPropsAnimation({ this.rootPage, this.pages });

  @override
  _EditPropsAnimationState createState() => _EditPropsAnimationState();
}

class _EditPropsAnimationState extends State<EditPropsAnimation> with SingleTickerProviderStateMixin {
  PageSliderController _pageSliderController;

  @override
  void initState() {
    super.initState();
    this._pageSliderController = PageSliderController(vsync: this, buildRoot: widget.rootPage, buildPages: widget.pages);
  }

  @override
  void didUpdateWidget(covariant EditPropsAnimation oldWidget) {
    this._pageSliderController.pages = widget.pages;

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return PageSliderAnimator(
      pageSliderController: this._pageSliderController,
      maxSlide: 300,
      slidesWidth: 311,
    );
  }
}

abstract class NodeContainer {
  ListElementNode selectedListElementNode;
}

class SchemaNodeList extends SchemaNode implements NodeContainer {
  Debouncer<String> textDebouncer;
  ListTemplateType listTemplateType;

  ListElementNode selectedListElementNode;

  SchemaNodeList({
    @required SchemaNodeSpawner parent,
    @required ListTemplateType listTemplateType,
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
  }) : super() {
    this.parentSpawner = parent;
    this.type = SchemaNodeType.list;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(375.0, getListHeightByType(listTemplateType));
    this.id = id ?? UniqueKey();
    this.listTemplateType = listTemplateType;
    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Table': SchemaStringProperty('Table', null),
          'Items': SchemaStringListProperty.sample(),
          'Template': SchemaListTemplateProperty(
              'Template', getListTemplateByType(listTemplateType)),
          'Elements': SchemaListElementsProperty(
              'Elements', ListElements(allColumns: listColumnsSample),
          ),
          'TextColor': SchemaMyThemePropProperty(
              'TextColor', parent.userActions.themeStore.currentTheme.general),
          'ItemColor': SchemaMyThemePropProperty(
              'ItemColor', parent.userActions.themeStore.currentTheme.background),
          'ItemRadiusValue': SchemaIntProperty('ItemRadiusValue', 8),
          'SeparatorsColor': SchemaMyThemePropProperty(
              'SeparatorsColor', parent.userActions.themeStore.currentTheme.separators),
          'BoxShadow': SchemaBoolProperty('BoxShadow', true),
          'BoxShadowColor': SchemaMyThemePropProperty(
              'BoxShadowColor', parent.userActions.themeStore.currentTheme.general),
          'BoxShadowBlur': SchemaIntProperty('BoxShadowBlur', 6),
          'BoxShadowOpacity': SchemaDoubleProperty('BoxShadowOpacity', 0.2),
          'ListItemHeight': SchemaDoubleProperty('ListItemHeight', 100),
        };

    textDebouncer = Debouncer(milliseconds: 500, prevValue: '322');
  }
// todo: refac.
  bool get isSelected => this.id == parentSpawner.userActions.selectedNode()?.id;

  void unselectListElementNode() {
    selectedListElementNode = null;

    if (this.pageSliderController != null) {
      pageSliderController.toRoot();
    }

    if (this.isSelected) {
      parentSpawner.userActions.rerenderNode();
    } else {
      parentSpawner.userActions.selectNodeForEdit(this);
    }
  }

  void selectListElementNode(ListElementNode listElementNode) {
    this.selectedListElementNode = listElementNode;

    if (this.pageSliderController != null) {
      pageSliderController.to(listElementNode.id);
    }

    this.parentSpawner.userActions.rerenderNode();
  }

  Offset get listElementNodeWorkspaceSize => Offset(
    this.size.dx - (this.properties['Template'].value as ListTemplate).padding.dx * 2,
    this.properties['ListItemHeight'].value - (this.properties['Template'].value as ListTemplate).padding.dy * 2,
  );

  @override
  void onDeletePressed({ Function onDelete }) {
    if (this.selectedListElementNode != null) {
      (this.properties['Elements'].value as ListElements).deleteListElementNode(
        listElementNode: selectedListElementNode,
      );

      unselectListElementNode();

      return;
    }

    super.onDeletePressed(onDelete: onDelete);
  }

  @override
  void onCopyPressed({onCopy}) {
    if (this.selectedListElementNode != null) {
      final ListElementNode copy =  (this.properties['Elements'].value as ListElements).copyListElementNode(
        listElementNode: selectedListElementNode,
      );

      copy.onListElementsUpdate();

      selectListElementNode(copy);

      return;
    }

    super.onCopyPressed(onCopy: onCopy);
  }

  @override
  void onUpOrDownPressed({bool isUp, Offset currentScreenWorkspaceSize, Function repositionAndResize}) {
    if (this.selectedListElementNode != null) {
      this.selectedListElementNode.onUpOrDownPressed(isUp: isUp, currentScreenWorkspaceSize: this.listElementNodeWorkspaceSize);

      return;
    }

    super.onUpOrDownPressed(isUp: isUp, currentScreenWorkspaceSize: currentScreenWorkspaceSize, repositionAndResize: repositionAndResize);
  }

  @override
  void onLeftOrRightPressed({bool isLeft, Offset currentScreenWorkspaceSize, Function repositionAndResize}) {
    if (this.selectedListElementNode != null) {
      this.selectedListElementNode.onLeftOrRightPressed(isLeft: isLeft, currentScreenWorkspaceSize: this.listElementNodeWorkspaceSize);

      return;
    }

    super.onLeftOrRightPressed(isLeft: isLeft, currentScreenWorkspaceSize: currentScreenWorkspaceSize, repositionAndResize: repositionAndResize);
  }

  @override
  double get onLeftResizeMinimalSize {
    double minimalSize = super.onLeftResizeMinimalSize;

    (this.properties['Elements'].value as ListElements).listElements.forEach((ListElementNode listElementNode) {
      double currentNodeMinimalSize = this.size.dx - listElementNode.node.position.dx;
      if (currentNodeMinimalSize > minimalSize) minimalSize = currentNodeMinimalSize;
    });

    return minimalSize;
  }

  @override
  double get onRightResizeMinimalSize {
    double minimalSize = super.onRightResizeMinimalSize;

    (this.properties['Elements'].value as ListElements).listElements.forEach((ListElementNode listElementNode) {
      double currentNodeMinimalSize = listElementNode.node.size.dx + listElementNode.node.position.dx;
      if (currentNodeMinimalSize > minimalSize) minimalSize = currentNodeMinimalSize;
    });

    double paddingToListItem = (this.properties['Template'].value as ListTemplate).padding.dx * 2;

    return minimalSize + paddingToListItem;
  }

  @override
  SchemaNode magnetLeftResize({
    @required double deltaDx,
    @required double screenSizeDx,
    @required GuidelinesManager guidelinesManager,
  }) {
    final double currentSize = this.size.dx;

    final SchemaNode editedNode = super.magnetLeftResize(deltaDx: deltaDx, screenSizeDx: screenSizeDx, guidelinesManager: guidelinesManager);

    final resizeDelta = editedNode.size.dx - currentSize;

    (this.properties['Elements'].value as ListElements).listElements.forEach((ListElementNode listElementNode) {
      listElementNode.onListLeftResize(deltaDx: resizeDelta, currentScreenWorkspaceSize: this.listElementNodeWorkspaceSize);
    });

    return editedNode;
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return parentSpawner.spawnSchemaNodeList(
      position: position ?? this.position,
      id: id ?? this.id,
      size: size ?? this.size,
      properties: saveProperties ? this._copyProperties() : null,
      listTemplateType: this.listTemplateType,
    );
  }

  Map<String, SchemaNodeProperty> _copyProperties() {
    final newProps = Map<String, SchemaNodeProperty>();
    this.properties.forEach((key, value) {
      newProps[key] = value.copy();
    });

    return newProps;
  }

  @override
  Widget toWidget({ bool isPlayMode }) {
    if (isPlayMode) {
      return Container(
        width: this.size.dx,
        height: this.size.dy,
        child: SingleChildScrollView(
          child: (this.properties['Template'].value as ListTemplate).toWidget(
            schemaNodeList: this,
            isPlayMode: isPlayMode,
          ),
        ),
      );
    }

    return Container(
      width: this.size.dx,
      height: this.size.dy,
      child: (this.properties['Template'].value as ListTemplate).toWidget(
        schemaNodeList: this,
        isPlayMode: isPlayMode,
      ),
    );
  }

  Future<void> updateData(String tableName, UserActions userActions) async {
    print('updateData');
    final client = userActions.currentUserStore.project.airtableTables
        .firstWhere((element) => element.table == tableName);
    print("Client: $client");

    final newProp = await SchemaStringListProperty.fromRemoteTable(client);
    userActions.changePropertyTo(newProp);
  }

  PageSliderController pageSliderController;

  @override
  Widget toEditProps(wrapInRootProps, Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo) {
    return ListToEditProps(
      schemaNodeList: this,
      wrapInRootProps: wrapInRootProps,
      changePropertyTo: changePropertyTo,
    );
  }
}

class ListToEditProps extends StatefulWidget {
  final SchemaNodeList schemaNodeList;
  final Function wrapInRootProps;
  final Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo;

  ListToEditProps({
    @required this.schemaNodeList,
    @required this.wrapInRootProps,
    @required this.changePropertyTo,
  });
  @override
  _ListToEditPropsState createState() => _ListToEditPropsState();
}

class _ListToEditPropsState extends State<ListToEditProps> with SingleTickerProviderStateMixin {
  PageSliderController _pageSliderController;

  @override
  void initState() {
    super.initState();

    this._pageSliderController = PageSliderController(
      vsync: this,
      buildRoot: this._buildRoot,
      buildPages: this.getPageSliderPages(),
    );

    // todo: refac?
    widget.schemaNodeList.pageSliderController = this._pageSliderController;
  }

  Map<UniqueKey, BuildWidgetFunction> getPageSliderPages() => (widget.schemaNodeList.properties['Elements'].value as ListElements)
    .getSettingsPagesBuildFunctions(
      getPageWrapFunction: getPageWrap,
    );

  WrapFunction getPageWrap(ListElementNode listElementNode) {
    return (Widget child) {
      return Column(
        children: [
          ToolboxHeader(
              leftWidget: IconCircleButton(
                  onTap: widget.schemaNodeList.unselectListElementNode,
                  assetPath: 'assets/icons/meta/btn-back.svg'),
              title: listElementNode.name,

            rightWidget: WithInfo(
                isShowAlways: true,
                isOnLeft: true,
                defaultDecoration: BoxDecoration(
                    gradient: MyGradients.plainWhite,
                    shape: BoxShape.circle),
                hoverDecoration: BoxDecoration(
                    gradient: MyGradients.lightBlue,
                    shape: BoxShape.circle),
                position: Offset(0, 2),
                onBringFront: () {
                  (widget.schemaNodeList.properties['Elements'].value as ListElements).bringToFrontListElementNode(
                    listElementNode: listElementNode,
                  );
                },
                onSendBack: () {
                  (widget.schemaNodeList.properties['Elements'].value as ListElements).sendToBackListElementNode(
                    listElementNode: listElementNode,
                  );
                },
                onDuplicate: () {
                  final ListElementNode copy =  (widget.schemaNodeList.properties['Elements'].value as ListElements).copyListElementNode(
                    listElementNode: listElementNode,
                  );

                  copy.onListElementsUpdate();

                  widget.schemaNodeList.selectListElementNode(copy);
                },
                onDelete: () {
                  (widget.schemaNodeList.properties['Elements'].value as ListElements).deleteListElementNode(
                    listElementNode: listElementNode,
                  );

                  widget.schemaNodeList.unselectListElementNode();
                },
                child: Container(
                  width: 38,
                  height: 38,
                  color: Colors.transparent,
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.0, left: 20, right: 10),
            child: child,
          ),
        ],
      );
    };
  }

  Widget _buildRoot() {
    final UserActions userActions = widget.schemaNodeList.parentSpawner.userActions;
    return widget.wrapInRootProps(
        Column(children: [
          ColumnDivider(
            name: 'Data Source',
          ),
          (userActions.currentUserStore.project != null &&
              userActions.currentUserStore.project.base != null)
              ? Row(
            children: [
              Text(
                'Table from',
                style: MyTextStyle.regularCaption,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: MyClickSelect(
                    placeholder: 'Select Table',
                    selectedValue: widget.schemaNodeList.properties['Table'].value ?? null,
                    onChange: (screen) async {
                      await widget.schemaNodeList.updateData(screen.value, userActions);
                      widget.changePropertyTo(
                          SchemaStringProperty('Table', screen.value));

                      widget.schemaNodeList.properties['Elements'].value.updateAllColumns(
                          userActions
                              .columnsFor(screen.value)
                              .map((e) => e.name)
                              .toList());
                    },
                    options: userActions.tables
                        .map((element) => SelectOption(element, element))
                        .toList()),
              )
            ],
          ) : ConnectAirtableModal(),
          ColumnDivider(
            name: 'Row Elements',
          ),
          (widget.schemaNodeList.properties['Elements'].value as ListElements).toEditProps(
              schemaNodeList: widget.schemaNodeList,
              onNodeSettingsClick: (ListElementNode listElementNode) {
                widget.schemaNodeList.selectListElementNode(listElementNode);
              },
              onListElementsUpdate: () {
                widget.changePropertyTo(SchemaListElementsProperty('Elements', widget.schemaNodeList.properties['Elements'].value));
                _pageSliderController.pages = getPageSliderPages();
              }
          ),
          ColumnDivider(
            name: 'Row Style',
          ),
          EditPropsColor(
            currentTheme: widget.schemaNodeList.parentSpawner.userActions.themeStore.currentTheme,
            properties: widget.schemaNodeList.properties,
            propName: 'ItemColor',
            changePropertyTo: widget.changePropertyTo,
          ),
          (widget.schemaNodeList.properties['Template'].value as ListTemplate).rowStyle(
            changePropertyTo: widget.changePropertyTo,
            properties: widget.schemaNodeList.properties,
            currentTheme: widget.schemaNodeList.parentSpawner.userActions.themeStore.currentTheme,
          ),
          SizedBox(
            height: 10,
          ),
        ])
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageSliderAnimator(
      pageSliderController: _pageSliderController,
      maxSlide: 300,
      slidesWidth: 311,
    );
  }
}

