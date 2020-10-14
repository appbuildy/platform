import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeIcon.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/MySwitch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:toast/toast.dart';

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

  void _createDetailedInfoForList(SchemaNode selectedNode, String tableName) {
    final screenName = 'Details for ${widget.userActions.currentScreen.name}';
    print('rowData ${selectedNode.properties['Items'].value.values.toList()}');
    final detailedInfo = DetailedInfo(
      tableName: tableName,
      rowData: selectedNode.properties['Items'].value.values
          .toList()[0]
          .value, // select first row data
      screenId: widget.userActions.currentScreen.id,
    );

    Toast.show("Details page Created", context,
        backgroundColor: MyColors.mainBlue,
        textColor: MyColors.white,
        duration: 2,
        gravity: Toast.TOP);

    final theme = widget.userActions.theme;
    final detailedComponents = [
      SchemaNodeImage(
          position: Offset(0, 0),
          url: detailedInfo.rowData[listColumnsSample[2]].data,
          column: listColumnsSample[2]),
      SchemaNodeIcon(
          theme: theme,
          position: Offset(14, 40),
          iconSize: 24,
          icon: FontAwesomeIcons.arrowLeft),
      SchemaNodeText(
          position: Offset(14, 220),
          theme: theme,
          text: detailedInfo.rowData[listColumnsSample[0]].data,
          column: listColumnsSample[0]),
      SchemaNodeText(
          position: Offset(14, 240),
          theme: theme,
          text: detailedInfo.rowData[listColumnsSample[1]].data,
          column: listColumnsSample[1]),
      SchemaNodeText(
          position: Offset(14, 380),
          theme: theme,
          text: detailedInfo.rowData[listColumnsSample[3]].data,
          column: listColumnsSample[3]),
      SchemaNodeButton(
          theme: theme, position: Offset(20, 300), text: 'Contact Us')
    ];

    widget.userActions.screens.createForList(
        moveToLastAfterCreated: true,
        name: screenName,
        detailedInfo: detailedInfo,
        detailedComponents: detailedComponents);

    widget.userActions.selectNodeForEdit(null);
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
                  } else {
                    if (selectedNode.type == SchemaNodeType.list) {
                      _createDetailedInfoForList(
                          selectedNode, selectedNode.properties['Table'].value);
                    }
                  }
                  isVisible = !isVisible;
                });
              },
            ),
            SizedBox(width: 11),
            Text(
              'Actions on Tap',
              style: MyTextStyle.regularTitle,
            ),
          ],
        ),
        isVisible
            ? Padding(
                padding: const EdgeInsets.only(top: 11.0),
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
                          defaultIcon: SizedBox(
                              width: 20.0,
                              height: 16.0,
                              child: Image.network(
                                  'assets/icons/meta/btn-navigate.svg')),
                          placeholder: 'Select Page',
                          selectedValue:
                              selectedNode.actions['Tap'].value ?? null,
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
              )
            : Container()
      ],
    );
  }
}
