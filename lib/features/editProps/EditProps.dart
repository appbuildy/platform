import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/ui/AllActions.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditProps extends StatelessWidget {
  final UserActions userActions;
  final SchemaNode selectedNode;

  const EditProps({
    Key key,
    @required this.userActions,
    @required this.selectedNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: selectedNode != null
          ? Column(children: [
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
              selectedNode.toEditProps(userActions.changePropertyTo),
              Text('ACTIONS'),
              Observer(
                builder: (_) => AllActions(
                  screens: userActions.screens.all.screens,
                ),
//                child: AllActions(
//                  screens: userActions.screens.all.screens,
//                ),
              ),
            ])
          : Container(),
    );
  }
}
