import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/AllActions.dart';
import 'package:flutter_app/ui/ColumnDivider.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';
import 'package:flutter_app/utils/CapitalizeString.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditProps extends StatelessWidget {
  final UserActions userActions;

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

        if (selectedNode == null) {
          return Container();
        }

        return Column(children: [
          ToolboxHeader(
              leftWidget: IconCircleButton(
                  onTap: () {
                    userActions.copyNode(selectedNode);
                  },
                  assetPath: 'assets/icons/meta/btn-duplicate.svg'),
              rightWidget: IconCircleButton(
                onTap: () {
                  userActions.deleteNode(selectedNode);
                },
                assetPath: 'assets/icons/meta/btn-delete.svg',
              ),
              title: selectedNode.type.toString().split('.')[1].capitalize()),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                selectedNode.toEditProps(userActions),
                ColumnDivider(),
                AllActions(
                  key: selectedNode.id,
                  userActions: userActions,
                  screens: screens,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
          ),
        ]);
      },
    );
  }
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.start,
//      children: [
//        SingleChildScrollView(
//          child: Observer(
//            builder: (BuildContext context) {
//              final selectedNode = userActions.selectedNode();
//              final screens = userActions.screens.all.screens;
//
//              if (selectedNode == null) {
//                return Container();
//              }
//
//              return Column(children: [
//                ToolboxHeader(
//                    leftWidget: IconCircleButton(
//                        onTap: () {
//                          userActions.copyNode(selectedNode);
//                        },
//                        assetPath: 'assets/icons/meta/btn-duplicate.svg'),
//                    rightWidget: IconCircleButton(
//                      onTap: () {
//                        userActions.deleteNode(selectedNode);
//                      },
//                      assetPath: 'assets/icons/meta/btn-delete.svg',
//                    ),
//                    title: selectedNode.type
//                        .toString()
//                        .split('.')[1]
//                        .capitalize()),
//                Padding(
//                  padding:
//                      const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0),
//                  child: Column(
//                    children: [
//                      selectedNode.toEditProps(userActions),
//                      ColumnDivider(),
//                      AllActions(
//                        key: selectedNode.id,
//                        userActions: userActions,
//                        screens: screens,
//                      ),
//                    ],
//                  ),
//                ),
//                SizedBox(
//                  height: 150,
//                ),
//              ]);
//            },
//          ),
//        ),
//      ],
//    );
//  }
}
