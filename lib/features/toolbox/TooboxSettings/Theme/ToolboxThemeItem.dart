import 'package:flutter/material.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/IconHover.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/DarkenColor.dart';

class ToolboxThemeItem extends StatefulWidget {
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

  @override
  _ToolboxThemeItemState createState() => _ToolboxThemeItemState();
}

class _ToolboxThemeItemState extends State<ToolboxThemeItem> {
  bool showIcon = false;

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
    final defaultDecoration = widget.isActive
        ? BoxDecoration(
        gradient: MyGradients.lightBlue,
        borderRadius: BorderRadius.circular(8))
        : BoxDecoration(
        gradient: MyGradients.plainWhite,
        borderRadius: BorderRadius.circular(8));

    final hoverDecoration = widget.isActive
        ? BoxDecoration(
        gradient: MyGradients.lightBlue,
        borderRadius: BorderRadius.circular(8))
        : BoxDecoration(
        gradient: MyGradients.lightGray,
        borderRadius: BorderRadius.circular(8));

    return GestureDetector(
      onTap: () {
        if (!widget.isActive) {
          widget.setTheme(widget.theme);
        }
      },
      child: Cursor(
        cursor: widget.isActive ? CursorEnum.defaultCursor : CursorEnum.pointer,
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              showIcon = true;
            });
          },
          onExit: (_) {
            setState(() {
              showIcon = false;
            });
          },
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
                                color: widget.theme.primary.color,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: 38,
                              height: 11,
                              decoration: BoxDecoration(
                                  color: widget.theme.secondary.color,
                                  border: Border.all(
                                      width: 1, color: widget.theme.separators.color),
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
                            widget.theme.name,
                            style: MyTextStyle.regularTitle,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                buildCircle(widget.theme.primary.color),
                                Positioned(
                                  left: 14,
                                  child: buildCircle(widget.theme.secondary.color),
                                ),
                                Positioned(
                                  left: 28,
                                  child: buildCircle(widget.theme.general.color),
                                ),
                                Positioned(
                                  left: 42,
                                  child: buildCircle(widget.theme.generalSecondary.color),
                                ),
                                Positioned(
                                  left: 56,
                                  child: buildCircle(widget.theme.generalInverted.color),
                                ),
                                Positioned(
                                  left: 70,
                                  child: buildCircle(widget.theme.separators.color),
                                ),
                                Positioned(
                                  left: 84,
                                  child: buildCircle(widget.theme.background.color),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  if (showIcon)
                    GestureDetector(
                      onTap: () {
                        widget.setTheme(widget.theme);
                        widget.onSettingsTap(widget.theme);
                      },
                      child: Cursor(
                          cursor: CursorEnum.pointer,
                          child: IconHover(assetPath: 'assets/icons/settings/action-edit-highlighted.svg')
                      ),
                    ),
                ],
              ),
            ),
            defaultDecoration: defaultDecoration,
            hoverDecoration: hoverDecoration,
          ),
        ),
      ),
    );
  }
}