import 'package:flutter/material.dart';
import 'package:flutter_app/features/canvas/SchemaNode.dart';

class ToolboxComponentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        ToolboxComponent(),
        ToolboxComponent(),
        ToolboxComponent(),
        ToolboxComponent(),
      ],
    );
  }
}

class ToolboxComponent extends StatelessWidget {
  Widget _buildToolbox() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.tealAccent)),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text('Button'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Draggable<SchemaNode>(
        data: SchemaNodeButton(position: null),
        feedback:
            Material(child: Opacity(opacity: 0.5, child: _buildToolbox())),
        childWhenDragging: Opacity(opacity: 0.5, child: _buildToolbox()),
        child: _buildToolbox(),
      ),
    );
  }
}
