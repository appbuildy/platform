import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UndoRedo extends StatelessWidget {
  final UserActions userActions;

  const UndoRedo({Key key, this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isRedoDisabled = true;

    return Observer(
      builder: (BuildContext context) {
        return Row(
          children: [
            IconCircleButton(
                onTap: userActions.undo,
                isDisabled: userActions.isActionsDoneEmpty,
                icon: Image.network(
                  'assets/icons/meta/action-undo.svg',
                  color:
                      userActions.isActionsDoneEmpty ? MyColors.iconGray : null,
                )),
            IconCircleButton(
                isDisabled: isRedoDisabled,
                icon: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Image.network(
                      'assets/icons/meta/action-undo.svg',
                      color: isRedoDisabled ? MyColors.iconGray : null,
                    ))),
          ],
        );
      },
//      child: Row(
//        children: [
//          IconCircleButton(
//              onTap: userActions.undo,
//              isDisabled: userActions.isActionsDoneEmpty,
//              image: Image.network(
//                'assets/icons/meta/action-undo.svg',
//                color: userActions.isActionsDoneEmpty ? MyColors.iconGray : null,
//              )),
//          IconCircleButton(
//              isDisabled: isRedoDisabled,
//              image: Transform(
//                  alignment: Alignment.center,
//                  transform: Matrix4.rotationY(math.pi),
//                  child: Image.network(
//                    'assets/icons/meta/action-undo.svg',
//                    color: isRedoDisabled ? MyColors.iconGray : null,
//                  ))),
//        ],
//      ),
    );
  }
}
