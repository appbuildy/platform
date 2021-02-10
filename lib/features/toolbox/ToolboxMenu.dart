import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/StringExtentions/CapitalizeString.dart';

enum ToolboxStates { layout, settings, pages, data }

class ToolboxMenu extends StatelessWidget {
  final ToolboxStates state;
  final Function(ToolboxStates) selectState;

  const ToolboxMenu({Key key, this.state, this.selectState}) : super(key: key);

  Widget buildOption(ToolboxStates option) {
    final isActive = option == state;

    final asset = option.toString().split('.')[1];
    final name = asset.capitalize();

    const borderRadius = BorderRadius.only(
        bottomRight: const Radius.circular(8),
        topRight: const Radius.circular(8));

    final activeDecoration = BoxDecoration(
        borderRadius: borderRadius, gradient: MyGradients.mediumBlue);

    return GestureDetector(
      onTap: () {
        selectState(option);
      },
      child: Cursor(
        cursor: isActive ? CursorEnum.defaultCursor : CursorEnum.pointer,
        child: Container(
          width: toolboxMenuWidth,
          height: 90,
          child: HoverDecoration(
              defaultDecoration: isActive
                  ? activeDecoration
                  : BoxDecoration(
                      borderRadius: borderRadius,
                      gradient: MyGradients.plainWhite),
              hoverDecoration: isActive
                  ? activeDecoration
                  : BoxDecoration(
                      borderRadius: borderRadius,
                      gradient: MyGradients.lightGray),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'assets/icons/menu/$asset-active.svg',
                    color: isActive ? null : Color(0XFFAABAD2),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isActive ? MyColors.textBlue : MyColors.black),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            html.window.open('https://build.appbuildy.com', '_self');
          },
          child: Cursor(
            cursor: CursorEnum.pointer,
            child: Container(
              width: toolboxMenuWidth,
              height: headerHeight,
              child: Image.network('assets/icons/meta/logo.svg'),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: MyColors.gray))),
            ),
          ),
        ),
        buildOption(ToolboxStates.pages),
        buildOption(ToolboxStates.layout),
        buildOption(ToolboxStates.data),
        buildOption(ToolboxStates.settings),
      ],
    );
  }
}
