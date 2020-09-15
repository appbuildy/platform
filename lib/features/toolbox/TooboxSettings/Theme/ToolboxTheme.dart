import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ToolboxTheme extends StatelessWidget {
  final UserActions userActions;

  const ToolboxTheme({Key key, this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        final theme = userActions.theme.currentTheme;

        return Column(
          children: [
            ToolboxThemeItem(
              theme: MyThemes.lightBlue,
              isActive: theme.name == MyThemes.lightBlue.name,
              setTheme: userActions.theme.setTheme,
            ),
            ToolboxThemeItem(
              theme: MyThemes.darkBlue,
              isActive: theme.name == MyThemes.darkBlue.name,
              setTheme: userActions.theme.setTheme,
            ),
          ],
        );
      },
    );
  }
}

class ToolboxThemeItem extends StatelessWidget {
  final bool isActive;
  final MyTheme theme;
  final Function setTheme;

  const ToolboxThemeItem(
      {Key key, this.isActive = false, @required this.theme, this.setTheme})
      : super(key: key);

  Widget buildCircle(Color color) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: MyColors.iconGray),
          shape: BoxShape.circle,
          color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = isActive
        ? BoxDecoration(
            gradient: MyGradients.lightBlue,
            borderRadius: BorderRadius.circular(8))
        : BoxDecoration(
            gradient: MyGradients.plainWhite,
            borderRadius: BorderRadius.circular(8));

    final hoverDecoration = isActive
        ? BoxDecoration(
            gradient: MyGradients.lightBlue,
            borderRadius: BorderRadius.circular(8))
        : BoxDecoration(
            gradient: MyGradients.lightGray,
            borderRadius: BorderRadius.circular(8));

    return GestureDetector(
      onTap: () {
        if (!isActive) {
          setTheme(theme);
        }
      },
      child: Cursor(
        cursor: isActive ? CursorEnum.defaultCursor : CursorEnum.pointer,
        child: HoverDecoration(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 11, bottom: 11, right: 16),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 38,
                      height: 48,
                      decoration: BoxDecoration(
                          color: theme.primary.color,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 38,
                        height: 11,
                        decoration: BoxDecoration(
                            color: theme.secondary.color,
                            border:
                                Border.all(width: 1, color: theme.body.color),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      theme.name,
                      style: MyTextStyle.regularTitle,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          buildCircle(theme.body.color),
                          Positioned(
                            left: 14,
                            child: buildCircle(theme.bodySecondary.color),
                          ),
                          Positioned(
                            left: 28,
                            child: buildCircle(theme.background.color),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          defaultDecoration: defaultDecoration,
          hoverDecoration: hoverDecoration,
        ),
      ),
    );
  }
}
