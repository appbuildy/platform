import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/features/appPreview/AppActions/UndoRedo.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AppActions extends StatelessWidget {
  final UserActions userActions;

  const AppActions({Key key, this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: headerHeight,
      decoration: BoxDecoration(
          color: MyColors.white,
          border: Border(
              left: BorderSide(width: 1, color: MyColors.gray),
              bottom: BorderSide(width: 1, color: MyColors.gray))),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 13.0, right: 13.0, top: 10.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UndoRedo(
              userActions: userActions,
            ),
            Observer(
              builder: (_) => Container(
                  width: 200,
                  child: MyHoverSelect(
                      selectedValue: userActions.screens.current.id,
                      onChange: (option) {
                        userActions.screens.selectById(option.value);
                      },
                      onAdd: () {
                        userActions.screens
                            .create(moveToLastAfterCreated: true);
                        userActions.selectNodeForEdit(null);
                      },
                      options: userActions.screens.all.screens
                          .map((element) =>
                              SelectOption(element.name, element.id))
                          .toList())),
            ),
            MaterialButton(onPressed: () {}, child: Text('Share')),
          ],
        ),
      ),
    );
  }
}
