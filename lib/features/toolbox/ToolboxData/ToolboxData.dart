import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/ConnectAirtableModal.dart';

import '../ToolboxUI.dart';

class ToolboxData extends StatefulWidget {
  final UserAction userActions;

  const ToolboxData({Key key, @required this.userActions}) : super(key: key);

  @override
  _ToolboxDataState createState() => _ToolboxDataState();
}

class _ToolboxDataState extends State<ToolboxData> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: toolboxWidth,
      height: MediaQuery.of(context).size.height,
      child: widget.userActions.currentUserStore?.project?.slugUrl == null
          ? Column(
              children: [
                ToolboxTitle(
                  title: 'Data',
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: ConnectAirtableModal(isInToolbox: true),
                ),
                SizedBox(
                  height: 150,
                ),
                Spacer(),
              ],
            )
          : null,
    );
  }
}
