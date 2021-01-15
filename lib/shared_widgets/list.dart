import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeList.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/lists/ListTemplates/ListTemplate.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';

void emptyFunc() {}

class List extends StatefulWidget {
  const List(
      {Key key,
      this.theme,
      this.size,
      this.properties,
      this.schemaNodeList = null,
      this.onListClick = emptyFunc,
      this.onListItemClick = emptyFunc,
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
  final Function onListItemClick;
  final bool isSelected;
  final bool isPlayMode;
  final bool isBuild;
  final Project project;

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  IRemoteTable get remoteTable => widget.project.airtableTables
      .firstWhere((table) => table.table == widget.properties['Table'].value);

  Map<String, SchemaNodeProperty> newProperties;

  @override
  void initState() {
    super.initState();
    newProperties = widget.properties;

    if (widget.isBuild && widget.properties['Table'].value != null) {
      SchemaStringListProperty.fromRemoteTable(remoteTable).then((value) {
        setState(() {
          newProperties['Items'] = value;
        });
      });
    }
  }

  @override
  void didUpdateWidget(covariant List oldWidget) {
    super.didUpdateWidget(oldWidget);

    final prevItems = newProperties['Items'];
    setState(() {
      newProperties = widget.properties;
      newProperties['Items'] = prevItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.dx,
      height: widget.size.dy,
      child: (widget.properties['Template'].value as ListTemplate).toWidget(
        schemaNodeList: widget.schemaNodeList,
        size: widget.size,
        onListClick: widget.onListClick,
        onListItemClick: widget.onListItemClick,
        theme: widget.theme,
        properties: newProperties,
        isSelected: widget.isSelected,
        isPlayMode: widget.isPlayMode || widget.isBuild,
      ),
    );
  }
}
