import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';

class EditPage extends StatelessWidget {
  final UserActions userActions;

  const EditPage({Key key, this.userActions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentScreen = userActions.screens.current;

    return Column(
      children: [
        ToolboxHeader(
          title: currentScreen.name,
          isRight: true,
        )
      ],
    );
  }
}
