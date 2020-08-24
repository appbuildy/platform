import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';

class EditProps extends StatelessWidget {
  final SchemaNode selectedNode;
  final UserActions userActions;

  const EditProps({Key key, this.selectedNode, this.userActions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: selectedNode != null
          ? Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Container(
                  child: MaterialButton(
                    color: Colors.red,
                    onPressed: () {
                      userActions.deleteNode(selectedNode);
                    },
                    child: Text('DELETE'),
                  ),
                ),
              ),
              selectedNode.toEditProps(userActions.changePropertyTo)
            ])
          : Container(),
    );
  }
}
