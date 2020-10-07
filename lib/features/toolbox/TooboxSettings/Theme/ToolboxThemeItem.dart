import 'package:flutter/material.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/IconHover.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/DarkenColor.dart';

class ToolboxThemeItem extends StatelessWidget {
  final bool isActive;
  final MyTheme theme;
  final Function setTheme;
  final Function onSettingsTap;

  const ToolboxThemeItem({
    Key key,
    this.isActive = false,
    @required this.theme,
    this.setTheme,
    @required this.onSettingsTap,
  }) : super(key: key);

  Widget buildCircle(Color color) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: color.darken()),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                                border: Border.all(
                                    width: 1, color: theme.separators.color),
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
                              buildCircle(theme.primary.color),
                              Positioned(
                                left: 14,
                                child: buildCircle(theme.secondary.color),
                              ),
                              Positioned(
                                left: 28,
                                child: buildCircle(theme.general.color),
                              ),
                              Positioned(
                                left: 42,
                                child: buildCircle(theme.generalSecondary.color),
                              ),
                              Positioned(
                                left: 56,
                                child: buildCircle(theme.generalInverted.color),
                              ),
                              Positioned(
                                left: 70,
                                child: buildCircle(theme.separators.color),
                              ),
                              Positioned(
                                left: 84,
                                child: buildCircle(theme.background.color),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    onSettingsTap(theme);
                  },
                  child: IconHover(assetPath: 'assets/icons/settings/action-edit-highlighted.svg'),
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