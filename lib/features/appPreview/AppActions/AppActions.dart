// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/features/appPreview/AppActions/UndoRedo.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyModal.dart';
import 'package:flutter_app/ui/MySelects/MySelects.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AppActions extends StatelessWidget {
  final UserActions userActions;

  const AppActions({Key key, this.userActions}) : super(key: key);

  void _showShareModal(context) {
    final MyModal modal = MyModal();
    modal.show(
        context: context,
        width: 750,
        height: 350,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                    height: 350,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 34.0,
                        left: 40,
                        right: 40,
                        bottom: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Share Project',
                            style: MyTextStyle.giantTitle,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'This is a link to preview your App on the Web',
                            style: MyTextStyle.mediumTitle,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 350,
                            child: MyTextField(
                              onChanged: () {},
                              disabled: false,
                              defaultValue: userActions
                                      .currentUserStore?.project?.slugUrl ??
                                  '',
                            ),
                          ),
                          Expanded(child: Container()),
                          MyButton(
                              onTap: () {
                                js.context.callMethod('open', [
                                  userActions
                                          .currentUserStore?.project?.slugUrl ??
                                      ''
                                ]);
                              },
                              text: 'Navigate to the Web App')
                        ],
                      ),
                    )),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [
                      Color(0xFF61e4ff).withOpacity(0.2),
                      Color(0xFF00a0ff).withOpacity(0.24)
                    ],
                  )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 34,
                        ),
                        QrImage(
                          data:
                              userActions.currentUserStore?.project?.slugUrl ??
                                  'https://www.appbuildy.com',
                          version: QrVersions.auto,
                          padding: EdgeInsets.zero,
                          size: 220,
                          gapless: true,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Scan QR code from your phone to open the app',
                          style: TextStyle(
                              color: MyColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onClose: () {});
  }

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
                        userActions.selectNodeForEdit(null);
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
            MyShareButton(
                onTap: () {
                  _showShareModal(context);
                },
                text: 'Share'),
          ],
        ),
      ),
    );
  }
}

class MyShareButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final Function onTap;

  const MyShareButton({Key key, @required this.text, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: MyColors.mainBlue, width: 2),
      gradient: MyGradients.plainWhite,
    );
    final hoverDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: MyColors.mainBlue, width: 2),
      gradient: MyGradients.lightBlue,
    );

    return GestureDetector(
      onTap: onTap,
      child: Cursor(
        cursor: CursorEnum.pointer,
        child: HoverDecoration(
          defaultDecoration: defaultDecoration,
          hoverDecoration: hoverDecoration,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 7, left: 16, right: 16),
            child: Row(
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: MyColors.textBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                Image.network('assets/icons/meta/btn-share.svg')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
