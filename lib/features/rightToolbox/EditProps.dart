import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/AllActions.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';
import 'package:flutter_app/utils/CapitalizeString.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditProps extends StatelessWidget {
  final UserActions userActions;

  const EditProps({
    Key key,
    @required this.userActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        final selectedNode = userActions.selectedNode();
        final screens = userActions.screens.all.screens;

        if (selectedNode == null) {
          return Container();
        }

        return Column(children: [
          ToolboxHeader(
              title: selectedNode.type.toString().split('.')[1].capitalize()),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              children: [
                MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    userActions.deleteNode(selectedNode);
                  },
                  child: Text('DELETE'),
                ),
                MaterialButton(
                  color: Colors.indigo,
                  onPressed: () {
                    userActions.copyNode(selectedNode);
                  },
                  child: Text('COPY'),
                )
              ],
            ),
          ),
          selectedNode.toEditProps(userActions),
          Text('ACTIONS'),
          AllActions(
            userActions: userActions,
            screens: screens,
          ),
        ]);
      },
    );
  }
}
