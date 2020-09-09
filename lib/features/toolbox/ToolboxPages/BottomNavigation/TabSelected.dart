import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/ToolboxPages/BottomNavigation/iconsList.dart';
import 'package:flutter_app/store/schema/BottomNavigationStore.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelect.dart';
import 'package:flutter_app/ui/MyTextField.dart';
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
                  child: MySelect(
                      selectedValue: tab.target,
                      onChange: (screen) {
                        tab.target = screen.value;
                        userActions.bottomNavigation.updateTab(tab);
                        rerender();
                      },
                      options: userActions.screens.all.screens
                          .map((element) =>
                              SelectOption(element.name, element.name))
                          .toList()),
                )
              ],
            );
          },
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'Tab Icon',
          style: MyTextStyle.regularTitle,
        ),
        SizedBox(
          height: 14,
        ),
        Container(
          child: FaIcon(
            tab.icon,
            color: MyColors.iconDarkGray,
            size: 54,
          ),
        ),
        Container(
          width: 300,
          height: MediaQuery.of(context).size.height - 200,
          child: ListView.builder(
              itemCount: allIconsList.length,
              itemBuilder: (context, index) {
                if (allIconsList[index].length == 1) {
                  return _buildText(allIconsList[index][0]);
                } else {
                  return _buildRow(allIconsList[index]);
                }
              }),
        )
      ],
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
