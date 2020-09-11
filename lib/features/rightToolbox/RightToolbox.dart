import 'package:flutter/material.dart';
import 'package:flutter_app/features/rightToolbox/EditPage.dart';
import 'package:flutter_app/features/rightToolbox/EditProps.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/ToolboxMenu.dart';
import 'package:flutter_app/ui/MyColors.dart';

class RightToolbox extends StatelessWidget {
  final UserActions userActions;
  final ToolboxStates toolboxState;
  final Function(ToolboxStates) selectState;

  const RightToolbox(
      {Key key, this.userActions, this.toolboxState, this.selectState})
      : super(key: key);

  Widget buildWidgetOnState() {
    switch (toolboxState) {
      case ToolboxStates.settings:
        return Container();
      case ToolboxStates.layout:
        return EditProps(
          userActions: userActions,
        );
      case ToolboxStates.pages:
        return EditPage(userActions: userActions);
      case ToolboxStates.data:
        return Container();
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: buildWidgetOnState(),
    );
  }
}
