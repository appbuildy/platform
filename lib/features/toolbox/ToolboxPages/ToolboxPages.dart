import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/ToolboxPages/Pages.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/ui/MyButton.dart';

class ToolboxPages extends StatelessWidget {
  final UserActions userActions;

  const ToolboxPages({Key key, this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: toolboxWidth,
      child: Column(
        children: [
          ToolboxTitle(
            'Tabs & Pages',
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Column(
              children: [
                ToolBoxCaption('Tabs'),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: MyButton(
                      text: 'Add Tab',
                      icon: Image.network('assets/icons/meta/btn-plus.svg')),
                ),
                ToolBoxCaption('Pages'),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: MyButton(
                    text: 'Add Page',
                    icon: Image.network('assets/icons/meta/btn-plus.svg'),
                    onTap: () {
                      userActions.screens.create(moveToNextAfterCreated: true);
                      userActions.selectNodeForEdit(null);
                    },
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                ToolboxPagesWidget(userActions: userActions)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
