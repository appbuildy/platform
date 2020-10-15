import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/MySwitch.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'EditPageBackgroundColor.dart';

class EditPage extends StatelessWidget {
  final UserActions userActions;

  const EditPage({Key key, this.userActions}) : super(key: key);

  Widget _buildDetailedInfoScreen() {
    final detailedInfo = userActions.currentScreen.detailedInfo;

    if (detailedInfo == null) {
      return Container();
    }

    return Column(children: [
      ColumnDivider(
        name: 'Data Source',
      ),
      Row(
        children: [
          Text(
            'Table from',
            style: MyTextStyle.regularCaption,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: MyClickSelect(
                selectedValue: detailedInfo.tableName,
                defaultIcon: SizedBox(
                    width: 20.0,
                    height: 16.0,
                    child: Image.network('assets/icons/meta/btn-navigate.svg')),
                disabled: true,
                onChange: (screen) {},
                options: [
                  SelectOption(detailedInfo.tableName, detailedInfo.tableName)
                ]),
          )
        ],
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        'This is the special page created automatically for the list on Page 3. \nThat way each element on this page can be linked to the each row you tap.',
        style: TextStyle(color: Color(0xFF777777), fontSize: 14, height: 1.45),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        final currentScreen = userActions.screens.current;

        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(left: BorderSide(width: 1, color: MyColors.gray))),
              child: ToolboxHeader(
                title: userActions.screens.current.name,
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                rightWidget: IconCircleButton(
                    onTap: () {
                      userActions.screens.delete(currentScreen);
                    },
                    assetPath: 'assets/icons/meta/btn-delete.svg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                children: [
                  _buildDetailedInfoScreen(),
                  ColumnDivider(
                    name: 'Page Settings',
                  ),
                  EditBackgroundColor(
                    currentTheme: userActions.currentTheme,
                    onChange: (SelectOption option) {
                      currentScreen.setBackgroundColor(option.value);
                    },
                    selectedValue: currentScreen.backgroundColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text(
                            'Name',
                            style: MyTextStyle.regularCaption,
                          ),
                        ),
                        Expanded(
                          child: MyTextField(
                            key: currentScreen.id,
                            onChanged: (text) {
                              currentScreen.setName(text);
                            },
                            defaultValue: currentScreen.name,
                          ),
                        )
                      ]),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      MySwitch(
                        value: currentScreen.bottomTabsVisible,
                        onTap: () {
                          currentScreen
                              .setBottomTabs(!currentScreen.bottomTabsVisible);
                        },
                      ),
                      SizedBox(width: 11),
                      Text(
                        'Bottom Tabs',
                        style: MyTextStyle.regularTitle,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
