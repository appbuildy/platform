import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/ui/MyColors.dart';

const toolboxWidth = 311.0;

class ToolboxTitle extends StatelessWidget {
  final String title;

  const ToolboxTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: kHeaderHeight,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: MyColors.gray,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 10,
                  ),
                  child: Text(
                    title,
                    style: MyTextStyle.mediumTitle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ToolBoxCaption extends StatelessWidget {
  final String title;

  const ToolBoxCaption(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 11.0),
      child: Text(title, style: MyTextStyle.regularTitle),
    );
  }
}
