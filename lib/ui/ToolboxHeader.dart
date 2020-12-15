import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/ui/MyColors.dart';

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
    return SizedBox(
      height: kHeaderHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: MyColors.gray,
          )),
        ),
        child: Padding(
          padding: padding ??
              const EdgeInsets.only(
                left: 20.0,
                right: 10.0,
              ),
          child: Row(children: [
            leftWidget ?? SizedBox(height: 38, width: 38),
            Expanded(
              child: Align(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Text(
                    title,
                    style: MyTextStyle.mediumTitle,
                  ),
                ),
              ),
            ),
            rightWidget ?? SizedBox(height: 38, width: 38),
          ]),
        ),
      ),
    );
  }
}
