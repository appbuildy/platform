import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';

class ToolboxPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: toolboxWidth,
      child: Column(
        children: [
          ToolboxTitle(
            'Tabs & Pages',
          )
        ],
      ),
    );
  }
}
