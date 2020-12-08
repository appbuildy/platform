import 'package:flutter/material.dart';
import 'package:flutter_app/features/rightToolbox/EditPage.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringListProperty.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_app/ui/AllActions.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';
import 'package:flutter_app/ui/WithInfo.dart';
import 'package:flutter_app/utils/StringExtentions/CapitalizeString.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditProps extends StatelessWidget {
  final UserAction userActions;

  const EditProps({
    Key key,
    @required this.userActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        final selectedNode = userActions.selectedNode();
        final screens = userActions.screens.all.screens;
        final detailedInfo = userActions.currentScreen.detailedInfo;
        var columns = [];

        if (detailedInfo != null) {
          columns = detailedInfo.tableName != null
              ? userActions
                  .columnsFor(detailedInfo.tableName)
                  .map((e) => e.name)
                  .toList()
              : [...listColumnsSample];
        }

        if (selectedNode == null) {
          return EditPage(
            userActions: userActions,
          );
        }

        return Column(children: [
          Container(
            decoration: BoxDecoration(
                border:
                    Border(left: BorderSide(width: 1, color: MyColors.gray))),
            child: ToolboxHeader(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                leftWidget: IconCircleButton(
                  onTap: () {
                    userActions.selectNodeForEdit(null);
                  },
                  assetPath: 'assets/icons/meta/btn-close.svg',
                ),
                rightWidget: WithInfo(
                    isShowAlways: true,
                    isOnLeft: true,
                    defaultDecoration: BoxDecoration(
                        gradient: MyGradients.plainWhite,
                        shape: BoxShape.circle),
                    hoverDecoration: BoxDecoration(
                        gradient: MyGradients.lightBlue,
                        shape: BoxShape.circle),
                    position: Offset(0, 2),
                    onBringFront: () {
                      userActions.currentScreen.bringFront(selectedNode);
                    },
                    onSendBack: () {
                      userActions.currentScreen.sendBack(selectedNode);
                    },
                    onDuplicate: () {
                      userActions.copyNode(selectedNode);
                    },
                    onDelete: () {
                      userActions.deleteNode(selectedNode);
                    },
                    child: Container(
                      width: 38,
                      height: 38,
                      color: Colors.transparent,
                    )),
                title: selectedNode.type.toString().split('.')[1].capitalize()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                AllActions(
                  key: selectedNode.id,
                  userActions: userActions,
                  screens: screens,
                ),
                detailedInfo != null &&
                        selectedNode.properties['Column'] != null
                    ? Column(
                        children: [
                          ColumnDivider(name: 'Data Source'),
                          Row(
                            children: [
                              SizedBox(
                                child: Text('Column'),
                                width: 59,
                              ),
                              Expanded(
                                  child: MyClickSelect(
                                placeholder: 'Select Column',
                                selectedValue:
                                    selectedNode.properties['Column'].value,
                                defaultIcon: Container(
                                    child: Image.network(
                                  'assets/icons/meta/btn-detailed-info-big.svg',
                                  fit: BoxFit.contain,
                                )),
                                onChange: (SelectOption element) {
                                  userActions.changePropertyTo(
                                      SchemaStringProperty(
                                          'Column', element.value));
                                  (selectedNode as dynamic)
                                      .updateOnColumnDataChange(
                                          userActions,
                                          detailedInfo
                                              .rowData[element.value].data);
                                },
                                options: columns
                                    .map((e) => SelectOption(e, e))
                                    .toList(),
                              ))
                            ],
                          )
                        ],
                      )
                    : Container(),
                selectedNode.toEditProps(userActions),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ]);
      },
    );
  }
}
