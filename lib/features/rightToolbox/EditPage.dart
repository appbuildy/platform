import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySwitch.dart';
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
            ToolboxHeader(
              title: userActions.screens.current.name,
              isRight: true,
              rightWidget: IconCircleButton(
                  onTap: () {
                    userActions.screens.delete(currentScreen);
                  },
                  assetPath: 'assets/icons/meta/btn-delete.svg'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24.0),
              child: Row(
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
            )
          ],
        );
      },
    );
  }
}
