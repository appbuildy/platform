import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateCards.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateSimple.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

enum ListTemplateType { simple, cards }

abstract class ListTemplate {
  ListTemplateType getType();

  Widget toWidget({
    MyTheme currentTheme,
    Map<String, SchemaNodeProperty> properties,
    bool isPlayMode,
  });

  Widget rowStyle({
    Map<String, SchemaNodeProperty> properties,
    UserAction userActions,
    MyTheme currentTheme,
  });

  Widget widgetFor({
    SchemaListItemsProperty item,
    ListElements elements,
    MyTheme currentTheme,
  });
}

ListTemplate getListTemplateByType(ListTemplateType type) {
  switch (type) {
    case ListTemplateType.cards:
      return ListTemplateCards();
    case ListTemplateType.simple:
    default:
      return ListTemplateSimple();
  }
}

double getListHeightByType(ListTemplateType type) {
  switch (type) {
    case ListTemplateType.cards:
      return 480.0;
    case ListTemplateType.simple:
    default:
      return 195.0;
  }
}
