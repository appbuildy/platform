import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/TooboxSettings/ToolboxSettings.dart';
import 'package:flutter_app/features/toolbox/ToolboxLayout.dart';
import 'package:flutter_app/features/toolbox/ToolboxMenu.dart';
import 'package:flutter_app/features/toolbox/ToolboxPages/ToolboxPages.dart';
import 'package:flutter_app/ui/MyColors.dart';

class Toolbox extends StatelessWidget {
  final UserActions userActions;
  final ToolboxStates toolboxState;
  final Function(ToolboxStates) selectState;

  const Toolbox(
      {Key key, this.userActions, this.toolboxState, this.selectState})
      : super(key: key);

  Widget buildWidgetOnState() {
    switch (toolboxState) {
      case ToolboxStates.settings:
        return ToolboxSettings(userActions: userActions);
      case ToolboxStates.layout:
        return ToolboxLayout();
      case ToolboxStates.pages:
        return ToolboxPages(
          userActions: userActions,
        );
      case ToolboxStates.data:
        return Container();
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
              child:
                  ToolboxMenu(state: toolboxState, selectState: selectState)),
          SingleChildScrollView(child: buildWidgetOnState()),
          Column(
            children: [],
          ), // to align the CihnleChildScrollViews
        ],
      ),
    );
  }
}
