import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsCorners.dart';
import 'package:flutter_app/features/schemaNodes/common/EditPropsText.dart';
import 'package:flutter_app/features/schemaNodes/my_do_nothing_action.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaDoubleProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/shared_widgets/image.dart' as Shared;
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MyClickSelect.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/utils/Debouncer.dart';

import 'SchemaNodeSpawner.dart';
import 'common/EditPropsOpacity.dart';
import 'implementations.dart';

const String defaultPicture =
    'https://images.unsplash.com/photo-1549880338-65ddcdfd017b';

class SchemaNodeImage extends SchemaNode implements DataContainer {
  Debouncer<String> textDebouncer;

  SchemaNodeImage(
      {@required SchemaNodeSpawner parent,
      Offset position,
      Offset size,
      Map<String, SchemaNodeProperty> properties,
      String column,
      Map<String, SchemaNodeProperty> actions,
      String url,
      UniqueKey id})
      : super() {
    this.parentSpawner = parent;
    this.type = SchemaNodeType.image;
    this.position = position ?? Offset(0, 0);
    this.size = size ?? Offset(375.0, 210.0);
    this.id = id ?? UniqueKey();
    this.actions = actions ?? {'Tap': MyDoNothingAction('Tap')};
    this.properties = properties ??
        {
          'Url': SchemaStringProperty('Url', url ?? defaultPicture),
          'Column': SchemaStringProperty('Column', column ?? null),
          'BorderRadiusValue': SchemaIntProperty('BorderRadiusValue', 0),
          'Fit': SchemaStringProperty('Fit', 'Cover'),
          'Opacity': SchemaDoubleProperty('Opacity', 1),
        };
    textDebouncer =
        Debouncer(milliseconds: 500, prevValue: this.properties['Url'].value);
  }

  @override
  SchemaNode copy(
      {Offset position,
      Offset size,
      UniqueKey id,
      bool saveProperties = true}) {
    return parentSpawner.spawnSchemaNodeImage(
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
  Widget toWidget({bool isPlayMode}) {
    return Shared.Image(properties: this.properties, size: this.size);
  }

  Widget toWidgetWithReplacedData(
      {bool isPlayMode, String data, MyTheme theme = null}) {
    var properties = this._copyProperties();
    properties['Url'] = SchemaStringProperty('Url', data ?? 'no_data');

    return Shared.Image(properties: properties, size: size);
  }

  void updateOnColumnDataChange(String newValue) {
    parentSpawner.userActions
        .changePropertyTo(SchemaStringProperty("Url", newValue), false);
  }

  @override
  Widget toEditProps(wrapInRootProps,
      Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo) {
    return wrapInRootProps(Column(children: [
      ColumnDivider(name: 'Edit Data'),
      EditPropsText(
        title: 'Url',
        id: id,
        properties: properties,
        propName: 'Url',
        changePropertyTo: changePropertyTo,
        textDebouncer: textDebouncer,
      ),
      this.toEditOnlyStyle(changePropertyTo),
    ]));
  }

  Widget toEditOnlyStyle(
      Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo) {
    return Column(children: [
      ColumnDivider(
        name: 'Image Style',
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 59,
            child: Text(
              'Resize',
              style: MyTextStyle.regularCaption,
            ),
          ),
          Expanded(
            child: MyClickSelect(
              options: [
                SelectOption('Fill', 'Fill'),
                SelectOption('Cover', 'Cover'),
                SelectOption('Contain', 'Contain'),
                SelectOption('None', 'None')
              ],
              selectedValue: properties['Fit'].value,
              onChange: (SelectOption option) {
                changePropertyTo(SchemaStringProperty('Fit', option.value));
              },
            ),
          ),
        ],
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
    ]);
  }
}
