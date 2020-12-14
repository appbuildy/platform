import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateCards.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateSimple.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

enum ListTemplateType { simple, cards }

abstract class ListTemplate {
  ListTemplateType getType();

  Widget toWidget({
    @required Function onListClick, // should mock it in skeleton
    @required MyTheme theme,
    @required Offset size,
    @required Map<String, SchemaNodeProperty> properties,
    @required bool isSelected,
    SchemaNodeList schemaNodeList,
    @required bool isPlayMode,
  });

  Widget rowStyle({
    Map<String, SchemaNodeProperty> properties,
    Function(SchemaNodeProperty, [bool, dynamic]) changePropertyTo,
    MyTheme currentTheme,
  });

  Widget widgetFor({
    @required SchemaListItemsProperty item,
    @required SchemaNodeList schemaNodeList,
    @required bool isPlayMode,
  });
}

ListTemplate getListTemplateByType(ListTemplateType type) {
  if (type == ListTemplateType.simple) {
    return ListTemplateSimple();
  } else if (type == ListTemplateType.cards) {
    return ListTemplateCards();
  } else {
    return ListTemplateSimple();
  }
}

double getListHeightByType(ListTemplateType type) {
  if (type == ListTemplateType.simple) {
    return 195.0;
  } else if (type == ListTemplateType.cards) {
    return 480.0;
  } else {
    return 195.0;
  }
}

double getListItemHeightByType(ListTemplateType type) {
  if (type == ListTemplateType.simple) {
    return 100.0;
  } else if (type == ListTemplateType.cards) {
    return 150.0;
  } else {
    return 100.0;
  }
}

double getListItemPaddingByType(ListTemplateType type) {
  if (type == ListTemplateType.simple) {
    return 0.0;
  } else if (type == ListTemplateType.cards) {
    return 15.0;
  } else {
    return 0.0;
  }
}

double getAspectRatio(
    {Offset size, Map<String, SchemaNodeProperty> properties}) {
  final width = size.dx - properties['ListItemPadding'].value * 2;
  final additionalPaddings = (properties['ListItemsPerRow'].value - 1) *
      properties['ListItemPadding'].value;
  final height = properties['ListItemHeight'].value;

  final aspectRatio =
      ((width - additionalPaddings) / properties['ListItemsPerRow'].value) /
          height;

  return aspectRatio;
}
