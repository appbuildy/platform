import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/MySwitch.dart';
import 'package:mobx/mobx.dart';

class AllActions extends StatefulWidget {
  final ObservableList<SchemaStore> screens;
  final UserActions userActions;

  const AllActions(
      {Key key, @required this.userActions, @required this.screens})
      : super(key: key);

  @override
  _AllActionsState createState() => _AllActionsState();
}

class _AllActionsState extends State<AllActions> {
  bool isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = widget.userActions.selectedNode().actions['Tap'].value != null;
  }

  @override
  Widget build(BuildContext context) {
    final selectedNode = widget.userActions.selectedNode();

    return Column(
      children: [
        Row(
          children: [
            MySwitch(
              value: isVisible,
              onTap: () {
                setState(() {
                  if (isVisible) {
                    widget.userActions
                        .changeActionTo(GoToScreenAction('Tap', null));
                  }
                  isVisible = !isVisible;
                });
              },
            ),
            SizedBox(width: 11),
            Text(
              'Navigate to Page on tap',
              style: MyTextStyle.regularTitle,
            ),
          ],
        ),
        SizedBox(
          height: 11,
        ),
        AbsorbPointer(
          absorbing: !isVisible,
          child: Opacity(
            opacity: isVisible ? 1 : 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Navigate to',
                  style: MyTextStyle.regularCaption,
                ),
                Container(
                  width: 170,
                  child: MyClickSelect(
                      isOpenOnTop: true,
                      placeholder: 'Select Page',
                      selectedValue: selectedNode.actions['Tap'].value ?? null,
                      onChange: (screen) {
                        widget.userActions.changeActionTo(
                            GoToScreenAction('Tap', screen.value));
                      },
                      options: widget.userActions.screens.all.screens
                          .map((element) =>
                              SelectOption(element.name, element.id))
                          .toList()),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
