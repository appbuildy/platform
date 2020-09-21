import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySwitch.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditPage extends StatelessWidget {
  final UserActions userActions;

  const EditPage({Key key, this.userActions}) : super(key: key);

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
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24.0),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name',
                          style: MyTextStyle.regularCaption,
                        ),
                        Container(
                          width: 170,
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
                    height: 24,
                  ),
                  Container(
                    height: 1,
                    width: 260,
                    decoration: BoxDecoration(
                        color: MyColors.gray,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  SizedBox(
                    height: 24,
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
