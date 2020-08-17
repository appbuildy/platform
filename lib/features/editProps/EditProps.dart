import 'package:flutter/material.dart';
import 'package:flutter_app/features/canvas/SchemaNode.dart';

class EditProps extends StatelessWidget {
  final SchemaNode selectedNode;

  const EditProps({Key key, this.selectedNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: selectedNode != null ? selectedNode.toEditProps() : Container(),
    );
  }
}
