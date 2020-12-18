import 'package:flutter/material.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/ConnectAirtableModal.dart';

import 'package:flutter_app/features/toolbox/ToolboxUI.dart';

import 'package:flutter_app/constants.dart';
import 'package:flutter_app/ui/IFrame/IFrame.dart';

class ToolboxData extends StatefulWidget {
  final UserActions userActions;

  const ToolboxData({Key key, @required this.userActions}) : super(key: key);

  @override
  _ToolboxDataState createState() => _ToolboxDataState();
}

class _ToolboxDataState extends State<ToolboxData> {
  Widget buildConnectAirtable() {
    return Column(
      children: [
        ToolboxTitle(
          'Data',
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: ConnectAirtableModal(isInToolbox: true, userActions: widget.userActions),
        ),
        SizedBox(
          height: 150,
        ),
        Expanded(
          child: Container(),
        )
      ],
    );
  }

  void renderBaseViewOverlayEntry(base) {
    this.baseViewOverlayEntry =  OverlayEntry(
        builder: (context) {
          var screenSize = MediaQuery.of(context).size;

          return Padding(
            padding: EdgeInsets.only(left: toolboxMenuWidth),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: screenSize.width - toolboxMenuWidth,
              height: screenSize.height,
              child: IFrame(
                key: UniqueKey(),
                src: 'https://airtable.com/$base',
              ),
            ),
          );
        }
    );
  }

  OverlayEntry baseViewOverlayEntry;

  @override
  void dispose() {
    this.baseViewOverlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Project project =  widget.userActions.currentUserStore.project;
    final bool isBaseSet = project != null && project.base != null;

    if (isBaseSet) {
      this.renderBaseViewOverlayEntry(project.base);

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Overlay.of(context).insert(this.baseViewOverlayEntry);
      });

      return Container();
    }

    return Container(
      width: toolboxWidth,
      height: MediaQuery.of(context).size.height,
      child: buildConnectAirtable(),
    );
  }
}
