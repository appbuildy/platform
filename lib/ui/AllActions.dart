import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/ChangeableProperty.dart';
import 'package:flutter_app/features/schemaNodes/Functionable.dart';
import 'package:flutter_app/features/schemaNodes/GoBackAction.dart';
import 'package:flutter_app/features/schemaNodes/GoToScreenAction.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/my_do_nothing_action.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
import 'package:flutter_app/store/schema/DetailedInfo.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/userActions/AddScreen.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/MySwitch.dart';
import 'package:flutter_app/utils/ShowToast.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    isVisible =
        (widget.userActions.selectedNode().actions['Tap'] as Functionable)
                .type !=
            SchemaActionType.doNothing;
  }

  void _createDetailedInfoForList(SchemaNode selectedNode, String tableName) {
    final screenName = 'Details for ${widget.userActions.currentScreen.name}';
    final detailedInfo = DetailedInfo(
      tableName: tableName,
      rowData: selectedNode.properties['Items'].value.values
          .toList()[0]
          .value, // select first row data
      screenId: widget.userActions.currentScreen.id,
    );

    ShowToast.info("Details page created", context);

    final themeStore = widget.userActions.themeStore;
    final listColumns = detailedInfo.tableName != null
        ? widget.userActions
            .columnsFor(detailedInfo.tableName)
            .map((e) => e.name)
            .toList()
        : listColumnsSample;

    bool isInRange(int index) {
      return listColumns.length >= index + 1;
    }

    final detailedComponents = [
      widget.userActions.schemaNodeSpawner.spawnSchemaNodeImage(
        position: Offset(0, 0),
        url: isInRange(2)
            ? detailedInfo.rowData[listColumns[2]].data
            : detailedInfo.rowData[listColumns[0]].data,
        column: isInRange(2) ? listColumns[2] : listColumns[0],
      ),
      widget.userActions.schemaNodeSpawner.spawnSchemaNodeIcon(
          position: Offset(14, 40),
          tapAction: GoBackAction('Tap', detailedInfo.screenId),
          iconSize: 24,
          icon: FontAwesomeIcons.arrowLeft),
      widget.userActions.schemaNodeSpawner.spawnSchemaNodeText(
          position: Offset(14, 220),
          size: Offset(343, 35),
          text: isInRange(0)
              ? detailedInfo.rowData[listColumns[0]].data
              : detailedInfo.rowData[listColumns[0]].data,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          column: isInRange(0) ? listColumns[0] : listColumns[0]),
      widget.userActions.schemaNodeSpawner.spawnSchemaNodeText(
          position: Offset(14, 260),
          size: Offset(343, 25),
          text: isInRange(1)
              ? detailedInfo.rowData[listColumns[1]].data
              : detailedInfo.rowData[listColumns[0]].data,
          fontWeight: FontWeight.w400,
          color: themeStore.currentTheme.generalSecondary,
          column: isInRange(1) ? listColumns[1] : listColumns[0]),
      widget.userActions.schemaNodeSpawner
          .spawnSchemaNodeButton(position: Offset(15, 295), text: 'Contact Us'),
      widget.userActions.schemaNodeSpawner.spawnSchemaNodeText(
          position: Offset(14, 360),
          size: Offset(343, 300),
          text: isInRange(3)
              ? detailedInfo.rowData[listColumns[3]].data
              : detailedInfo.rowData[listColumns[0]].data,
          fontWeight: FontWeight.w400,
          column: isInRange(3) ? listColumns[3] : listColumns[0]),
    ];

    final addScreenAction = widget.userActions.screens.createForList(
        moveToLastAfterCreated: true,
        name: screenName,
        detailedInfo: detailedInfo,
        detailedComponents: detailedComponents);

    // fucking async code, right?
    Future.delayed(Duration(milliseconds: 0), () {
      widget.userActions.changeActionTo(GoToScreenAction(
          'Tap', (addScreenAction as AddScreen).createdScreen.id));

      Future.delayed(Duration(milliseconds: 10), () {
        widget.userActions.selectNodeForEdit(null);
      });
    });
  }

  Widget buildActionSelect() {
    final actionsList = [
      SelectOption(
          'Navigate to',
          SchemaActionType.goToScreen,
          Image.network(
            'assets/icons/meta/btn-action-navigate.svg',
          )),
      SelectOption(
          'Go Back',
          SchemaActionType.goBack,
          Image.network(
            'assets/icons/meta/btn-action-back.svg',
          )),
      SelectOption('Open Link', SchemaActionType.openLink,
          Image.network('assets/icons/meta/btn-action-link.svg')),
      SelectOption('Make API Request', SchemaActionType.apiCall,
          Image.network('assets/icons/meta/btn-action-api.svg')),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Text(
              'Action',
              style: MyTextStyle.regularCaption,
            ),
            width: 59,
          ),
          Expanded(
            child: MyClickSelect(
                placeholder: 'Select Action',
                selectedValue: (widget.userActions.selectedNode().actions['Tap']
                        as Functionable)
                    .type,
                onChange: (screen) {
                  widget.userActions
                      .changeActionTo(getActionByType(screen.value, null));
                },
                options: actionsList.toList()),
          )
        ],
      ),
    );
  }

  bool hasColumnSelectByType(SchemaActionType type) {
    return ![
      SchemaActionType.doNothing,
      SchemaActionType.goToScreen,
      SchemaActionType.goBack
    ].contains(type);
  }

  Widget buildColumnSelect(UserActions userActions) {
    final selectedNode = userActions.selectedNode();
    final screens = userActions.screens.all.screens;
    final detailedInfo = userActions.currentScreen.detailedInfo;
    var columns = detailedInfo.tableName != null
        ? userActions
            .columnsFor(detailedInfo.tableName)
            .map((e) => e.name)
            .toList()
        : [...listColumnsSample];

    return Padding(
      padding: const EdgeInsets.only(top: 11.0),
      child: Row(
        children: [
          SizedBox(
            child: Text('Column'),
            width: 59,
          ),
          Expanded(
              child: MyClickSelect(
            placeholder: 'Select Column',
            selectedValue: (selectedNode.actions['Tap'] as Functionable).column,
            defaultIcon: Container(
                child: Image.network(
              'assets/icons/meta/btn-detailed-info-big.svg',
              fit: BoxFit.contain,
            )),
            onChange: (SelectOption element) {
              final currentAction =
                  (selectedNode.actions['Tap'] as Functionable);
              currentAction.column = element.value;

              (currentAction as SchemaNodeProperty).value =
                  detailedInfo.rowData[element.value].data;

              userActions
                  .changeActionTo(currentAction as ChangeableProperty<dynamic>);
            },
            options: columns.map((e) => SelectOption(e, e)).toList(),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        final selectedNode = widget.userActions.selectedNode();

        if (selectedNode.type == SchemaNodeType.form) {
          return Container();
        }
        return Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
            children: [
              Row(
                children: [
                  MySwitch(
                    value: isVisible,
                    onTap: () {
                      setState(() {
                        if (isVisible) {
                          widget.userActions
                              .changeActionTo(MyDoNothingAction('Tap'));
                        } else {
                          if (selectedNode.type == SchemaNodeType.list) {
                            _createDetailedInfoForList(selectedNode,
                                selectedNode.properties['Table'].value);
                            Future.delayed(Duration(milliseconds: 50), () {
                              widget.userActions.selectNodeForEdit(null);
                            });
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
              isVisible ? buildActionSelect() : Container(),
              isVisible &&
                      widget.userActions.currentScreen.detailedInfo != null &&
                      hasColumnSelectByType((widget.userActions
                              .selectedNode()
                              .actions['Tap'] as Functionable)
                          .type)
                  ? buildColumnSelect(widget.userActions)
                  : Container(),
              isVisible
                  ? Padding(
                      padding: const EdgeInsets.only(top: 11.0),
                      child: (widget.userActions.selectedNode().actions['Tap']
                              as Functionable)
                          .toEditProps(widget.userActions),
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }
}
