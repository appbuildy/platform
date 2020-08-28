import 'package:flutter/material.dart';
import 'package:flutter_app/features/toolbox/ToolboxComponentsList.dart';
import 'package:flutter_app/features/toolbox/ToolboxMenu.dart';
import 'package:flutter_app/ui/MyColors.dart';

class Toolbox extends StatefulWidget {
  @override
  _ToolboxState createState() => _ToolboxState();
}

class _ToolboxState extends State<Toolbox> {
  MenuStates state;

  @override
  void initState() {
    state = MenuStates.layout;
    super.initState();
  }

  void selectState(MenuStates newState) {
    if (newState != state) {
      setState(() {
        state = newState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: Row(
        children: [
          ToolboxMenu(state: state, selectState: selectState),
          SizedBox(
            width: 20,
          ),
          ToolboxComponentsList()
        ],
      ),
    );
  }
}
