import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListElements.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateCards.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplateSimple.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaListItemsProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

import '../../SchemaNodeList.dart';

enum ListTemplateType { simple, cards }

abstract class ListTemplate {
  ListTemplateType getType();

  Widget toWidget({
    @required SchemaNodeList schemaNodeList,
    // MyTheme currentTheme,
    // Map<String, SchemaNodeProperty> properties,
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
    // ListElements elements,
    // MyTheme currentTheme,
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
