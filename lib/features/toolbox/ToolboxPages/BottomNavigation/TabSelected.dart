import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/ui/MySelect.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TabSelected extends StatelessWidget {
  final TabNavigation tab;
  final Function rerender;
  final UserActions userActions;

  const TabSelected({Key key, this.tab, this.userActions, this.rerender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Navigate to'),
                Container(
                  width: 170,
                  child: MySelect(
                      selectedValue: tab.target,
                      onChange: (screen) {
                        tab.target = screen.value;
//                        final updatedTabNavigation = TabNavigation(
//                            target: screen.value,
//                            icon: tab.icon,
//                            label: tab.label,
//                            id: tab.id);
                        userActions.bottomNavigation.updateTab(tab);
                        rerender();
                      },
                      options: userActions.screens.all.screens
                          .map((element) =>
                              SelectOption(element.name, element.name))
                          .toList()),
                )
              ],
            )
          ],
        );
      },
    );
  }
}

//MySelect(
//selectedValue: userActions.screens.current.name,
//onChange: (option) {
//userActions.screens.selectByName(option.value);
//},
//options: userActions.screens.all.screens
//    .map((element) =>
//SelectOption(element.name, element.name))
//.toList())
