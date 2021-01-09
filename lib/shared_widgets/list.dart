import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

void emptyFunc() {}

class List extends StatelessWidget {
  const List(
      {Key key,
      this.theme,
      this.size,
      this.properties,
      this.schemaNodeList = null,
      this.onListClick = emptyFunc,
      this.isPlayMode = false,
      this.isSelected = false,
      this.project = null,
      this.isBuild = false})
      : super(key: key);

  final Map<String, SchemaNodeProperty> properties;
  final Offset size;
  final MyTheme theme;
  final SchemaNodeList schemaNodeList; // needs to correct work in AppPreview
  final Function onListClick;
  final bool isSelected;
  final bool isPlayMode;
  final bool isBuild;
  final Project project;

  IRemoteTable get remoteTable => project.airtableTables
      .firstWhere((table) => table.table == properties['Table'].value);

  @override
  Widget build(BuildContext context) {
    //properties['Items'] = SchemaStringListProperty.fromRemoteTable(remoteTable);

    return Container(
      width: size.dx,
      height: size.dy,
      child: (properties['Template'].value as ListTemplate).toWidget(
        schemaNodeList: schemaNodeList,
        size: size,
        onListClick: onListClick,
        theme: theme,
        properties: properties,
        isSelected: isSelected,
        isPlayMode: isPlayMode || isBuild,
      ),
    );
  }
}
