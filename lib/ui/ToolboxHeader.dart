import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';

class ToolboxHeader extends StatelessWidget {
  final Widget leftWidget;
  final Widget rightWidget;
  final String title;
  final bool isRight;

  const ToolboxHeader(
      {Key key,
      this.leftWidget,
      this.rightWidget,
      @required this.title,
      this.isRight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = isRight
        ? const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          )
        : const EdgeInsets.only(
            left: 20.0,
            right: 10.0,
          );

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: MyColors.gray))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: Row(
          children: [
            leftWidget ?? Container(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Center(
                  child: Padding(
                    padding: padding,
                    child: Text(
                      title,
                      style: MyTextStyle.mediumTitle,
                    ),
                  ),
                ),
              ),
            ),
            rightWidget ?? Container(),
          ],
        ),
      ),
    );
  }
}
