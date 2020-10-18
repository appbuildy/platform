import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/WithInfo.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Pages extends StatelessWidget {
  final UserActions userActions;

  const Pages({Key key, @required this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: userActions.screens.all.screens
            .map((element) => PageItem(
                  title: element.name,
                  isActive: element.id == userActions.screens.current.id,
                  onTap: () {
                    userActions.screens.selectById(element.id);
                    userActions.selectNodeForEdit(null);
                  },
                  onDelete: () {
                    userActions.screens.delete(element);
                  },
                  onDuplicate: () {
                    userActions.screens.duplicate(duplicatingScreen: element);
                  },
                ))
            .toList(),
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  final bool isActive;
  final String title;
  final Function onTap;
  final Function onDelete;
  final Function onDuplicate;

  const PageItem(
      {Key key,
      this.isActive,
      this.title,
      this.onTap,
      this.onDelete,
      this.onDuplicate})
      : super(key: key);

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
          onTap();
        }
      },
      child: Cursor(
        cursor: isActive ? CursorEnum.defaultCursor : CursorEnum.pointer,
        child: WithInfo(
          hoverDecoration: hoverDecoration,
          defaultDecoration: defaultDecoration,
          position: Offset(10.0, 4.5),
          onDuplicate: onDuplicate,
          onDelete: onDelete,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 13, bottom: 12, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: MyTextStyle.regularTitle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
