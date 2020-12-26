import 'package:flutter/material.dart';
import 'package:flutter_app/config/constants.dart';
import 'package:flutter_app/config/colors.dart';
import 'package:flutter_app/config/text_styles.dart';

class ToolboxHeader extends StatelessWidget {
  final Widget leftWidget;
  final Widget rightWidget;
  final String title;
  final EdgeInsets padding;

  const ToolboxHeader(
      {Key key,
      this.leftWidget,
      this.rightWidget,
      @required this.title,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pad = padding ??
        const EdgeInsets.only(
          left: 20.0,
          right: 10.0,
        );

    return Container(
      height: builderConst.headerHeight,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: MyColors.gray))),
      child: Padding(
        padding: pad,
        child: Row(
          children: [
            leftWidget ?? Container(height: 38, width: 38),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Center(
                  child: Text(
                    title,
                    style: MyTextStyle.mediumTitle,
                  ),
                ),
              ),
            ),
            rightWidget ??
                Container(
                  height: 38,
                  width: 38,
                ),
          ],
        ),
      ),
    );
  }
}
