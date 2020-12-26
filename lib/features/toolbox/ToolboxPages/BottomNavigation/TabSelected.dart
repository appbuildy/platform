import 'package:flutter/material.dart';
import 'package:flutter_app/config/text_styles.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/store/schema/bottom_navigation/tab_navigation.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/config/colors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/ui/SelectIconList.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabSelected extends StatelessWidget {
  final TabNavigation tab;
  final Function rerender;
  final UserActions userActions;

  const TabSelected({Key key, this.tab, this.userActions, this.rerender})
      : super(key: key);

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7, top: 17),
      child: Text(
        text,
        style: MyTextStyle.regularCaption,
      ),
    );
  }

  Widget _buildRowIcon(dynamic icon) {
    final isSelected = tab.icon == icon;

    if (icon == null) {
      return Container(
        width: 52,
        height: 52,
      );
    }

    final borderRadius = BorderRadius.circular(8);

    final defaultDecoration = isSelected
        ? BoxDecoration(
            gradient: MyGradients.lightBlue,
            borderRadius: borderRadius,
          )
        : BoxDecoration(
            gradient: MyGradients.plainWhite,
            borderRadius: borderRadius,
          );

    final hoverDecoration = isSelected
        ? BoxDecoration(
            gradient: MyGradients.lightBlue,
            borderRadius: borderRadius,
          )
        : BoxDecoration(
            gradient: MyGradients.lightGray,
            borderRadius: borderRadius,
          );

    return GestureDetector(
      onTap: () {
        tab.icon = icon;
        userActions.bottomNavigation.updateTab(tab);
        rerender();
      },
      child: Cursor(
        cursor: CursorEnum.pointer,
        child: Container(
            width: 52,
            height: 52,
            child: HoverDecoration(
              defaultDecoration: defaultDecoration,
              hoverDecoration: hoverDecoration,
              child: Center(
                child: FaIcon(
                  icon,
                  color: MyColors.iconDarkGray,
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildRow(List<dynamic> category) {
    return Row(
      children: <Widget>[
        _buildRowIcon(category[0]),
        _buildRowIcon(category[1]),
        _buildRowIcon(category[2]),
        _buildRowIcon(category[3]),
        _buildRowIcon(category[4]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Label',
            style: MyTextStyle.regularCaption,
          ),
          Container(
            width: 170,
            child: MyTextField(
              onChanged: (text) {
                tab.label = text;
                userActions.bottomNavigation.updateTab(tab);
                rerender();
              },
              defaultValue: tab.label,
            ),
          )
        ]),
        SizedBox(
          height: 10,
        ),
        Observer(
          builder: (BuildContext context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Navigate to',
                  style: MyTextStyle.regularCaption,
                ),
                Container(
                  width: 170,
                  child: MyClickSelect(
                    selectedValue: tab.target,
                    onChange: (screen) {
                      tab.target = screen.value;
                      userActions.bottomNavigation.updateTab(tab);
                      rerender();
                    },
                    options: userActions.screens.all.screens
                        .map(
                            (element) => SelectOption(element.name, element.id))
                        .toList(),
                    defaultIcon: SizedBox(
                        width: 20.0,
                        height: 16.0,
                        child: Image.network(
                            'assets/icons/meta/btn-navigate.svg')),
                  ),
                )
              ],
            );
          },
        ),
        SelectIconList(
            subListHeight: 290,
            selectedIcon: tab.icon,
            onChanged: (IconData icon) {
              tab.icon = icon;
              userActions.bottomNavigation.updateTab(tab);
              rerender();
            })
      ],
    );
  }
}
