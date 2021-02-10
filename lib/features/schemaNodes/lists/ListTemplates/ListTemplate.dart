import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateCards.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateHorizontal.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateSimple.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

enum ListTemplateType { simple, cards, horizontal }
enum ListTemplateStyle { compact, basic, tiles, cards, horizontalBasic }

abstract class ListTemplate {
  ListTemplateType getType();

  Widget toWidget({
    @required Function onListClick, // should mock it in skeleton
    @required Function onListItemClick, // should mock it in skeleton
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
  } else if (type == ListTemplateType.horizontal) {
    return ListTemplateHorizontal();
  } else {
    return ListTemplateSimple();
  }
}

double getListHeightByType(ListTemplateType type) {
  if (type == ListTemplateType.simple) {
    return 520.0;
  } else if (type == ListTemplateType.cards) {
    return 520.0;
  } else {
    return 195.0;
  }
}

double getListItemHeightByTypeAndStyle(
    ListTemplateType type, ListTemplateStyle style) {
  if (type == ListTemplateType.simple) {
    if (style == ListTemplateStyle.compact) {
      return 45.0;
    } else {
      return 65.0;
    }
  } else if (type == ListTemplateType.cards) {
    return 150.0;
  } else if (type == ListTemplateType.horizontal) {
    return 290.0;
  } else {
    return 100.0;
  }
}

double getListItemPaddingByType(ListTemplateType type) {
  if (type == ListTemplateType.simple) {
    return 0.0;
  } else if (type == ListTemplateType.cards) {
    return 15.0;
  } else if (type == ListTemplateType.horizontal) {
    return 15.0;
  } else {
    return 0.0;
  }
}

double getAspectRatio(
    {Offset size,
    Map<String, SchemaNodeProperty> properties,
    bool isReversed = false}) {
  final additionalPaddings = (properties['ListItemsPerRow'].value - 1) *
      properties['ListItemPadding'].value;
  double aspectRatio = 1;

  if (isReversed) {
    final height = size.dy - properties['ListItemPadding'].value * 2;
    final width = properties['ListItemHeight'].value;

    aspectRatio =
        ((height - additionalPaddings) / properties['ListItemsPerRow'].value) /
            width;
  } else {
    final width = size.dx - properties['ListItemPadding'].value * 2;
    final height = properties['ListItemHeight'].value;
    aspectRatio =
        ((width - additionalPaddings) / properties['ListItemsPerRow'].value) /
            height;
  }
  print('aspect ration $aspectRatio');

  return aspectRatio;
}
