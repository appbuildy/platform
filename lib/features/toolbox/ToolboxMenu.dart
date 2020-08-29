import 'package:flutter/material.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';

enum MenuStates { layout, general, pages, data }

const TitleToStateMap = {
  MenuStates.layout: 'Layout',
  MenuStates.pages: 'Pages',
  MenuStates.general: 'General',
  MenuStates.data: 'Data',
};

class ToolboxMenu extends StatelessWidget {
  final MenuStates state;
  final Function(MenuStates) selectState;

  const ToolboxMenu({Key key, this.state, this.selectState}) : super(key: key);

  Widget buildOption(MenuStates option) {
    final isActive = option == state;

//    final textWidget = Center(
//      child: Text(
//        TitleToStateMap[option],
//        style: TextStyle(
//            fontSize: 12,
//            fontWeight: FontWeight.bold,
//            color: isActive ? MyColors.textBlue : MyColors.black),
//      ),
//    );

    const borderRadius = BorderRadius.only(
        bottomRight: const Radius.circular(8),
        topRight: const Radius.circular(8));

    final activeDecoration = BoxDecoration(
        borderRadius: borderRadius, gradient: MyGradients.lightBlue);

    return GestureDetector(
      onTap: () {
        selectState(option);
      },
      child: Cursor(
        cursor: isActive ? CursorEnum.defaultCursor : CursorEnum.pointer,
        child: Container(
          width: 80,
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
                  Image.network('assets/icons/menu/layout-active.svg'),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    TitleToStateMap[option],
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
        buildOption(MenuStates.general),
        buildOption(MenuStates.pages),
        buildOption(MenuStates.layout),
        buildOption(MenuStates.data),
      ],
    );
  }
}
