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
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
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
    this._pageSliderController = PageSliderController(vsync: this, rootPage: widget.rootPage, pagesMap: widget.pages);
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
  Widget toEditPropsWithWrap(UserActions userActions, Function wrapFunc) {

    final Map<UniqueKey, BuildWidgetFunction> pages = {};

    (properties['Elements'].value as ListElements).listElements.forEach((ListElementNode e) => pages[e.nodeId] = e.buildWidgetToEditProps);
    print(pages);

    return EditPropsAnimation(rootPage: wrapFunc(this.toEditProps(userActions)), pages: pages);
  }

  @override
  Widget toEditProps(UserActions userActions) {
    return Column(children: [
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
                selectedValue: properties['Table'].value ?? null,
                onChange: (screen) async {
                  await updateData(screen.value, userActions);
                  userActions.changePropertyTo(
                      SchemaStringProperty('Table', screen.value));

                  properties['Elements'].value.updateAllColumns(userActions
                      .columnsFor(screen.value)
                      .map((e) => e.name)
                      .toList());
                },
                options: userActions.tables
                    .map((element) => SelectOption(element, element))
                    .toList()),
          )
        ],
      ),
      ColumnDivider(
        name: 'Row Elements',
      ),
      (properties['Elements'].value as ListElements).toEditProps(
        userActions: userActions,
        themeStore: themeStore,
        onNodeSettingsClick: (UniqueKey id) { print(id); }
      ),
      ColumnDivider(
        name: 'Row Style',
      ),
      EditPropsColor(
        currentTheme: themeStore.currentTheme,
        properties: properties,
        propName: 'ItemColor',
        userActions: userActions,
      ),
      this.properties['Template'].value.rowStyle(
          userActions: userActions,
          properties: properties,
          currentTheme: themeStore.currentTheme),
      SizedBox(
        height: 10,
      ),
    ]);
  }
}
