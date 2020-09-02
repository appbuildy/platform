import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/ToolboxLayout.dart';
import 'package:flutter_app/features/toolbox/ToolboxMenu.dart';
import 'package:flutter_app/features/toolbox/ToolboxPages/ToolboxPages.dart';
import 'package:flutter_app/ui/MyColors.dart';

class Toolbox extends StatefulWidget {
  final UserActions userActions;

  const Toolbox({Key key, this.userActions}) : super(key: key);

  @override
  _ToolboxState createState() => _ToolboxState();
}

class _ToolboxState extends State<Toolbox> {
  MenuStates state;

  @override
  void initState() {
    state = MenuStates.pages;
    super.initState();
  }

  void selectState(MenuStates newState) {
    if (newState != state) {
      setState(() {
        state = newState;
      });
    }
  }

  Widget buildWidgetOnState() {
    switch (state) {
      case MenuStates.settings:
        return Container();
      case MenuStates.layout:
        return ToolboxLayout();
      case MenuStates.pages:
        return ToolboxPages(
          userActions: widget.userActions,
        );
      case MenuStates.data:
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
              child: ToolboxMenu(state: state, selectState: selectState)),
          SingleChildScrollView(child: buildWidgetOnState()),
          Column(
            children: [],
          ), // to align the CihnleChildScrollViews
        ],
      ),
    );
  }
}
