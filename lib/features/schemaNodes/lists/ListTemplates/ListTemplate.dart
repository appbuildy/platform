import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListItem.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateCards.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateSimple.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/AppThemeStore.dart';

enum ListTemplateType { simple, cards }

abstract class ListTemplate {
  Widget widget(
      {SchemaStringListProperty items,
      ListElementsProperty elements,
      AppThemeStore theme});

  Widget widgetFor(
      {SchemaListItemProperty item,
      ListElements elements,
      AppThemeStore theme});
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