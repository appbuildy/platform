import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
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
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';
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
    this._pageSliderController = PageSliderController(vsync: this, buildRoot: widget.rootPage, pagesMap: widget.pages);
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


class SchemaNodeList extends SchemaNode {
  Debouncer<String> textDebouncer;
  ListTemplateType listTemplateType;

  SchemaNodeList(
      {Offset position,
      Offset size,
      @required AppThemeStore themeStore,
      @required ListTemplateType listTemplateType,
      Map<String, SchemaNodeProperty> properties,
      Map<String, SchemaNodeProperty> actions,
      UniqueKey id})
      : super() {
    this.type = SchemaNodeType.list;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(375.0, getListHeightByType(listTemplateType));
    this.id = id ?? UniqueKey();
    this.themeStore = themeStore;
    this.listTemplateType = listTemplateType;

    this.actions = actions ?? {'Tap': GoToScreenAction('Tap', null)};
    this.properties = properties ??
        {
          'Table': SchemaStringProperty('Table', null),
          'Items': SchemaStringListProperty.sample(),
          'Template': SchemaListTemplateProperty(
              'Template', getListTemplateByType(listTemplateType)),
          'Elements': ListElementsProperty(
              'Elements',
              ListElements(
                  allColumns: listColumnsSample,
                  // title: ListElement(
                  //     type: ListElementType.title,
                  //     column: listColumnsSample[0]),
                  // subtitle: ListElement(
                  //     type: ListElementType.subtitle,
                  //     column: listColumnsSample[1]),
                  // image: ListElement(
                  //     type: ListElementType.image,
                  //     column: listColumnsSample[2]),
                  // navigationIcon: ListElement(
                  //     type: ListElementType.navigationIcon, column: 'true',
                  // ),
              ),
          ),
          'TextColor': SchemaMyThemePropProperty(
              'TextColor', this.themeStore.currentTheme.general),
          'ItemColor': SchemaMyThemePropProperty(
              'ItemColor', this.themeStore.currentTheme.background),
          'ItemRadiusValue': SchemaIntProperty('ItemRadiusValue', 8),
          'SeparatorsColor': SchemaMyThemePropProperty(
              'SeparatorsColor', this.themeStore.currentTheme.separators),
          'BoxShadow': SchemaBoolProperty('BoxShadow', true),
          'BoxShadowColor': SchemaMyThemePropProperty(
              'BoxShadowColor', this.themeStore.currentTheme.general),
          'BoxShadowBlur': SchemaIntProperty('BoxShadowBlur', 6),
          'BoxShadowOpacity': SchemaDoubleProperty('BoxShadowOpacity', 0.2),
        };

    textDebouncer = Debouncer(milliseconds: 500, prevValue: '322');
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return SchemaNodeList(
      position: position ?? this.position,
      id: id ?? this.id,
      size: size ?? this.size,
      properties: saveProperties ? this._copyProperties() : null,
      themeStore: this.themeStore,
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
  Widget toWidget({bool isPlayMode, UserActions userActions}) {
    if (isPlayMode) {
      return Container(
          width: this.size.dx,
          height: this.size.dy,
          child: SingleChildScrollView(
            child: this.properties['Template'].value.toWidget(
                currentTheme: this.themeStore.currentTheme,
                properties: this.properties,
                actions: this.actions,
                userActions: userActions,
                isPlayMode: isPlayMode),
          ));
    }

    return Container(
        width: this.size.dx,
        height: this.size.dy,
        child: this.properties['Template'].value.toWidget(
            currentTheme: this.themeStore.currentTheme,
            properties: this.properties));
  }

  Future<void> updateData(String tableName, UserActions userActions) async {
    print('updateData');
    final client = userActions.currentUserStore.project.airtableTables
        .firstWhere((element) => element.table == tableName);
    print("Client: $client");

    final newProp = await SchemaStringListProperty.fromRemoteTable(client);
    userActions.changePropertyTo(newProp);
  }

  @override
  Widget toEditProps(UserActions userActions, wrapInRootProps) {
    return ListToEditProps(schemaNodeList: this, userActions: userActions, wrapInRootProps: wrapInRootProps);
  }
}

class ListToEditProps extends StatefulWidget {
  final SchemaNodeList schemaNodeList;
  final UserActions userActions;
  final Function wrapInRootProps;

  ListToEditProps({
    @required this.schemaNodeList,
    @required this.userActions,
    @required this.wrapInRootProps,
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
      pagesMap: this.getPageSliderPages(),
    );
  }

  Map<UniqueKey, BuildWidgetFunction> getPageSliderPages() {
    Map<UniqueKey, BuildWidgetFunction> pages = {};

    (widget.schemaNodeList.properties['Elements'].value as ListElements).listElements.forEach(
      (ListElementNode elementNode) => pages[elementNode.nodeId] = () => elementNode.buildWidgetToEditProps(getPageWrap(elementNode.name)),
    );

    return pages;
  }

  Function getPageWrap(nodeName) {
    return (Widget child) {
      return Column(
        children: [
          ToolboxHeader(
              leftWidget: IconCircleButton(
                  onTap: _pageSliderController.toRoot,
                  assetPath: 'assets/icons/meta/btn-back.svg'),
              title: nodeName),
          Padding(
            padding: EdgeInsets.only(top: 24.0, left: 20, right: 10),
            child: child,
          ),
        ],
      );
    };
  }

  Widget _buildRoot() {
    return widget.wrapInRootProps(
        Column(children: [
          ColumnDivider(
            name: 'Data Source',
          ),
          Row(
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
                      await widget.schemaNodeList.updateData(screen.value, widget.userActions);
                      widget.userActions.changePropertyTo(
                          SchemaStringProperty('Table', screen.value));

                      widget.schemaNodeList.properties['Elements'].value.updateAllColumns(
                          widget.userActions
                              .columnsFor(screen.value)
                              .map((e) => e.name)
                              .toList());
                    },
                    options: widget.userActions.tables
                        .map((element) => SelectOption(element, element))
                        .toList()),
              )
            ],
          ),
          ColumnDivider(
            name: 'Row Elements',
          ),
          (widget.schemaNodeList.properties['Elements'].value as ListElements).toEditProps(
              userActions: widget.userActions,
              themeStore: widget.schemaNodeList.themeStore,
              onNodeSettingsClick: (UniqueKey id) {
                _pageSliderController.to(id);
              },
              onListElementsUpdate: (ListElements listElements) {
                widget.userActions.changePropertyTo(ListElementsProperty('Elements', listElements));
                _pageSliderController.pages = getPageSliderPages();
              }
          ),
          ColumnDivider(
            name: 'Row Style',
          ),
          EditPropsColor(
            currentTheme: widget.schemaNodeList.themeStore.currentTheme,
            properties: widget.schemaNodeList.properties,
            propName: 'ItemColor',
            userActions: widget.userActions,
          ),
          widget.schemaNodeList.properties['Template'].value.rowStyle(
              userActions: widget.userActions,
              properties: widget.schemaNodeList.properties,
              currentTheme: widget.schemaNodeList.themeStore.currentTheme),
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

