import 'package:flutter/material.dart';
import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';

class EditProps extends StatelessWidget {
  final SchemaNode selectedNode;
  final UserActions userActions;

  const EditProps({Key key, this.selectedNode, this.userActions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: selectedNode != null
          ? selectedNode.toEditProps(userActions.changePropertyTo)
          : Container(),
    );
  }
}
