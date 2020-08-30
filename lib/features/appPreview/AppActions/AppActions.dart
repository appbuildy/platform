import 'package:flutter/material.dart';
import 'package:flutter_app/features/appPreview/AppActions/UndoRedo.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/utils/SchemaConverter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AppActions extends StatelessWidget {
  final UserActions userActions;

  const AppActions({Key key, this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUndoDisabled = userActions.lastAction() == null;
    final isRedoDisabled = true;

    return Container(
      decoration: BoxDecoration(
          color: MyColors.white,
          border: Border(
              left: BorderSide(width: 1, color: MyColors.gray),
              bottom: BorderSide(width: 1, color: MyColors.gray))),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 13.0, right: 13.0, top: 10.0, bottom: 8.0),
        child: Row(
          children: [
            UndoRedo(
              userActions: userActions,
            ),
            MaterialButton(
                onPressed: () {
                  userActions.screens.create(moveToNextAfterCreated: true);
                  userActions.selectNodeForEdit(null);
                },
                child: Text('Add')),
            MaterialButton(
                onPressed: () {
                  userActions.screens.previousScreen();
                  userActions.selectNodeForEdit(null);
                },
                child: Text('Previous')),
            Observer(
              builder: (context) => Text(
                userActions.screens.current.name,
                style: TextStyle(color: MyColors.mainBlue),
              ),
            ),
            MaterialButton(
                onPressed: () {
                  userActions.screens.nextScreen();
                  userActions.selectNodeForEdit(null);
                },
                child: Text('Next ')),
            MaterialButton(
                onPressed: () {
                  final json = SchemaConverter(userActions.screens.all)
                      .toJson()
                      .toString();
                  print(json);
                },
                child: Text('Print')),
          ],
        ),
      ),
    );
  }
}
