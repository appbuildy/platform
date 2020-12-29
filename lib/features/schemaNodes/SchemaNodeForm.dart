// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/ConnectAirtableModal.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsBorder.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsColor.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsFontStyle.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsOpacity.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsShadow.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsText.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaCrossAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaFontWeightProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListOfStringsProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMainAlignmentProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaMyThemePropProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/shared_widgets/form.dart' as Shared;
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/Counter.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/PageSliderAnimator.dart';
import 'package:flutter_app/ui/WithInfo.dart';
import 'package:flutter_app/utils/Debouncer.dart';

import 'my_do_nothing_action.dart';

class EditPropsAnimation extends StatefulWidget {
  final BuildWidgetFunction rootPage;
  final Map<UniqueKey, BuildWidgetFunction> pages;

  EditPropsAnimation({this.rootPage, this.pages});

  @override
  _EditPropsAnimationState createState() => _EditPropsAnimationState();
}

class _EditPropsAnimationState extends State<EditPropsAnimation>
    with SingleTickerProviderStateMixin {
  PageSliderController _pageSliderController;

  @override
  void initState() {
    super.initState();
    this._pageSliderController = PageSliderController(
        vsync: this, buildRoot: widget.rootPage, buildPages: widget.pages);
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

class SchemaNodeForm extends SchemaNode {
  Debouncer<String> textDebouncer;

  ListElementNode selectedListElementNode;

  SchemaNodeForm({
    @required SchemaNodeSpawner parent,
    UniqueKey id,
    Offset position,
    Offset size,
    Map<String, SchemaNodeProperty> properties,
    Map<String, SchemaNodeProperty> actions,
  }) : super() {
    this.parentSpawner = parent;
    this.type = SchemaNodeType.form;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(375.0, 350.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': MyDoNothingAction('Tap')};
    this.properties = properties ??
        {
          'Table': SchemaStringProperty('Table', null),
          'Base': SchemaStringProperty('Base', null),
          'AllColumns': SchemaListOfStringsProperty('AllColumns', []),
          'SelectedColumns': SchemaListOfStringsProperty(
              'SelectedColumns', ['Name', 'E-Mail', 'Description']),
          'TextColor': SchemaMyThemePropProperty(
              'TextColor', parent.userActions.themeStore.currentTheme.general),
          'ItemColor': SchemaMyThemePropProperty('ItemColor',
              parent.userActions.themeStore.currentTheme.background),
          'ItemRadiusValue': SchemaIntProperty('ItemRadiusValue', 8),
          'SeparatorsColor': SchemaMyThemePropProperty('SeparatorsColor',
              parent.userActions.themeStore.currentTheme.separators),
          'ListItemHeight': SchemaDoubleProperty('ListItemHeight', 100),
          'ListItemPadding': SchemaDoubleProperty('ListItemPadding', 8),
          'ListItemsPerRow': SchemaIntProperty('ListItemsPerRow', 1),
          //button styles
          'Text': SchemaStringProperty('Text', 'Submit'),
          'FontColor': SchemaMyThemePropProperty('FontColor',
              parent.userActions.themeStore.currentTheme.generalInverted),
          'FontSize': SchemaIntProperty('FontSize', 16),
          'FontWeight': SchemaFontWeightProperty('FontWeight', FontWeight.w500),
          'FontOpacity': SchemaDoubleProperty('FontOpacity', 1),
          'MainAlignment': SchemaMainAlignmentProperty(
              'MainAlignment', MainAxisAlignment.center),
          'CrossAlignment': SchemaCrossAlignmentProperty(
              'CrossAlignment', CrossAxisAlignment.center),
          'BackgroundColor': SchemaMyThemePropProperty('BackgroundColor',
              parent.userActions.themeStore.currentTheme.primary),
          'Border': SchemaBoolProperty('Border', false),
          'BorderColor': SchemaMyThemePropProperty('BorderColor',
              parent.userActions.themeStore.currentTheme.primary),
          'BorderWidth': SchemaIntProperty('BorderWidth', 1),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 9),
          'BoxShadow': SchemaBoolProperty('BoxShadow', false),
          'BoxShadowColor': SchemaMyThemePropProperty('BoxShadowColor',
              parent.userActions.themeStore.currentTheme.general),
          'BoxShadowBlur': SchemaIntProperty('BoxShadowBlur', 5),
          'BoxShadowOpacity': SchemaDoubleProperty('BoxShadowOpacity', 0.5),
          'Opacity': SchemaDoubleProperty('Opacity', 1),
        };

    textDebouncer = Debouncer(milliseconds: 500, prevValue: '322');
  }

  @override
  void onDeletePressed({Function onDelete}) {
    if (this.selectedListElementNode != null) {
      (this.properties['Elements'].value as ListElements).deleteListElementNode(
        listElementNode: selectedListElementNode,
      );

      parentSpawner.userActions.rerenderNode();

      return;
    }

    super.onDeletePressed(onDelete: onDelete);
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return parentSpawner.spawnSchemaNodeForm(
      position: position ?? this.position,
      id: id ?? this.id,
      size: size ?? this.size,
      properties: saveProperties ? this._copyProperties() : null,
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
  Widget toWidget({MyTheme theme, bool isPlayMode}) {
    if (properties['SelectedColumns'].value.length == 0) {
      return Container();
    }

    return Shared.Form(
        properties: this.properties,
        theme: theme ?? this.parentSpawner.userActions.themeStore.currentTheme,
        size: this.size,
        isInputsDisabled: !isPlayMode);
  }

  _buildInputsSelect() {
    final isNotEmpty = properties['SelectedColumns'].value.length > 0 &&
        properties['Table'].value != null;

    return Column(
        children: isNotEmpty
            ? [
                ColumnDivider(
                  name: 'Inputs',
                ),
                ...properties['SelectedColumns']
                    .value
                    .map((input) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            child: WithInfo(
                              isOnLeft: true,
                              onDelete: () {
                                parentSpawner.userActions.changePropertyTo(
                                    SchemaListOfStringsProperty(
                                        'SelectedColumns',
                                        properties['SelectedColumns']
                                            .value
                                            .where((i) => i != input)
                                            .toList()
                                            .cast<String>()));
                              },
                              position: Offset(10.0, 0.0),
                              defaultDecoration: BoxDecoration(
                                  gradient: MyGradients.buttonLightWhite,
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                      width: 1, color: MyColors.gray)),
                              hoverDecoration: BoxDecoration(
                                  gradient: MyGradients.buttonLightWhite,
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                      width: 1, color: MyColors.gray)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 12.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Text(
                                        input,
                                        style: MyTextStyle.regularTitle,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList()
                    .cast<Widget>()
              ]
            : []);
  }

  Future<void> updateData(String tableName, UserActions userActions) async {
    final client = userActions.currentUserStore.project.airtableTables
        .firstWhere((element) => element.table == tableName);
    final newProp = await SchemaStringListProperty.fromRemoteTable(client);
    final allColumns =
        newProp.value[newProp.value.keys.first].value.keys.toList();

    userActions.changePropertyTo(SchemaStringProperty('Table', tableName));
    userActions.changePropertyTo(
        SchemaListOfStringsProperty('AllColumns', allColumns));
    userActions.changePropertyTo(
        SchemaListOfStringsProperty('SelectedColumns', allColumns));
  }

  @override
  Widget toEditProps(wrapInRootProps,
      Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo) {
    return wrapInRootProps(Column(children: [
      ColumnDivider(
        name: 'Data Source',
      ),
      (parentSpawner.userActions.currentUserStore.project != null &&
              parentSpawner.userActions.currentUserStore.project.base != null)
          ? Column(
              children: [
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
                            await updateData(
                                screen.value, parentSpawner.userActions);
                          },
                          options: parentSpawner.userActions.tables
                              .map((element) => SelectOption(element, element))
                              .toList()),
                    )
                  ],
                ),
                _buildInputsSelect(),
              ],
            )
          : ConnectAirtableModal(),
      Column(
        children: [
          ColumnDivider(
            name: 'Inputs Style',
          ),
//          EditPropsColor(
//            currentTheme: parentSpawner.userActions.themeStore.currentTheme,
//            properties: properties,
//            propName: 'ItemColor',
//            changePropertyTo: changePropertyTo,
//          ),
//          SizedBox(
//            height: 12,
//          ),
//          Row(children: [
//            SizedBox(
//              width: 59,
//              child: Text(
//                'Height',
//                style: MyTextStyle.regularCaption,
//              ),
//            ),
//            Expanded(
//              child: MyTextField(
//                  defaultValue: properties['ListItemHeight'].value.toString(),
//                  onChanged: (String value) {
//                    changePropertyTo(SchemaDoubleProperty(
//                        'ListItemHeight', double.parse(value)));
//                  }),
//            )
//          ]),
          Row(children: [
            SizedBox(
              width: 100,
              child: Text(
                'Padding',
                style: MyTextStyle.regularCaption,
              ),
            ),
            Expanded(
              child: Counter(
                canBeZero: true,
                initNumber: properties['ListItemPadding'].value,
                counterCallback: (num) {
                  changePropertyTo(
                      SchemaDoubleProperty('ListItemPadding', num.toDouble()));
                },
              ),
            )
          ]),
//          SizedBox(
//            height: 15,
//          ),
//          EditPropsCorners(
//            value: properties['ItemRadiusValue'].value,
//            onChanged: (int value) {
//              changePropertyTo(SchemaIntProperty('ItemRadiusValue', value));
//            },
//          ),
          ColumnDivider(name: 'Button Settings'),
          EditPropsText(
            id: id,
            properties: properties,
            propName: 'Text',
            changePropertyTo: changePropertyTo,
            textDebouncer: textDebouncer,
          ),
          SizedBox(
            height: 12,
          ),
          ColumnDivider(name: 'Text Style'),
          EditPropsFontStyle(
            currentTheme: parentSpawner.userActions.currentTheme,
            changePropertyTo: changePropertyTo,
            properties: properties,
          ),
          ColumnDivider(name: 'Shape Style'),
          EditPropsColor(
            currentTheme: parentSpawner.userActions.currentTheme,
            properties: properties,
            changePropertyTo: changePropertyTo,
            propName: 'BackgroundColor',
          ),
          SizedBox(
            height: 12,
          ),
          EditPropsCorners(
            value: properties['BorderRadiusValue'].value,
            onChanged: (int value) {
              changePropertyTo(SchemaIntProperty('BorderRadiusValue', value));
            },
          ),
          SizedBox(
            height: 12,
          ),
          EditPropsOpacity(
            value: properties['Opacity'].value,
            onChanged: (double value) {
              changePropertyTo(SchemaDoubleProperty('Opacity', value));
            },
          ),
          SizedBox(
            height: 20,
          ),
          EditPropsBorder(
            key: id,
            properties: properties,
            changePropertyTo: changePropertyTo,
            currentTheme: parentSpawner.userActions.currentTheme,
          ),
          SizedBox(
            height: 15,
          ),
          EditPropsShadow(
            properties: properties,
            changePropertyTo: changePropertyTo,
            currentTheme: parentSpawner.userActions.currentTheme,
          ),
        ],
      )
    ]));
  }
}
