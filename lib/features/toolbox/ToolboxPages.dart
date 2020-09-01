import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/ui/MyButton.dart';

class ToolboxPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: toolboxWidth,
      child: Column(
        children: [
          ToolboxTitle(
            'Tabs & Pages',
          ),
          ToolBoxCaption('Tabs'),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Column(
              children: [
                MyButton(
                    text: 'Add Tab',
                    icon: Image.network('assets/icons/meta/btn-plus.svg'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
