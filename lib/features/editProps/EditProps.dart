import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/ui/AllActions.dart';
import 'package:mobx/mobx.dart';

class EditProps extends StatelessWidget {
  final UserActions userActions;
  final SchemaNode selectedNode;
  final ObservableList<SchemaStore> screens;

  const EditProps({
    Key key,
    @required this.userActions,
    @required this.selectedNode,
    this.screens,
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
              AllActions(
                userActions: userActions,
                screens: screens,
              ),
            ])
          : Container(),
    );
  }
}
