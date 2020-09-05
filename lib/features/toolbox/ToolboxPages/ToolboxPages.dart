import 'package:flutter/widgets.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/ToolboxPages/BottomNavigation/Tabs.dart';
import 'package:flutter_app/features/toolbox/ToolboxPages/Pages.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/ui/MyButton.dart';
import 'package:flutter_app/ui/MyColors.dart';

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
                ToolBoxCaption('Pages'),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: MyButton(
                    text: 'Add Page',
                    icon: Image.network('assets/icons/meta/btn-plus.svg'),
                    onTap: () {
                      userActions.screens.create(moveToLastAfterCreated: true);
                      userActions.selectNodeForEdit(null);
                    },
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Pages(userActions: userActions),
                SizedBox(height: 24),
                Container(
                  height: 1,
                  width: 260,
                  decoration: BoxDecoration(
                      color: MyColors.gray,
                      borderRadius: BorderRadius.circular(5)),
                ),
                ToolBoxCaption('Tabs'),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: MyButton(
                      text: 'Add Tab',
                      icon: Image.network('assets/icons/meta/btn-plus.svg')),
                ),
                SizedBox(
                  height: 17,
                ),
                Tabs(
                  userActions: userActions,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
