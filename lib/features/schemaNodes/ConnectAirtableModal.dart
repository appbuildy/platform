// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:io';
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MyLink.dart';
import 'package:flutter_app/ui/MyModal.dart';
import 'package:flutter_app/ui/MyTextField.dart';
import 'package:flutter_app/utils/ShowToast.dart';
import 'package:http/http.dart' as http;

class ConnectAirtableModal extends StatefulWidget {
  @override
  _ConnectAirtableModalState createState() => _ConnectAirtableModalState();
}

class _ConnectAirtableModalState extends State<ConnectAirtableModal> {
  String token;
  String base;
  String error;
  bool isBase;
  MyModal modal;

  @override
  void initState() {
    token = '';
    base = '';
    isBase = false;
    error = '';
    modal = MyModal();

    super.initState();
  }

  void handleTokenContinue() {
    final value = token.trim();
    if (value.length == 0) {
      setState(() {
        error = 'API Key should not be empty';
      });
      modal.show(
          context: context,
          width: 980,
          height: 425,
          child: renderToken(),
          onClose: () {});
    } else {
      setState(() {
        error = '';
        modal.show(
            context: context,
            width: 980,
            height: 475,
            child: renderBase(),
            onClose: () {});
      });
    }
  }

  void handleBaseContinue() async {
    final value = base.trim();

    if (value.length == 0) {
      setState(() {
        error = 'Base Link should not be empty';
      });
      modal.show(
          context: context,
          width: 980,
          height: 475,
          child: renderBase(),
          onClose: () {});
    } else {
      try {
        var response = await http.put('/api/project/123',
            body: json.encode({
              'airtable_credentials': {'api_key': token, 'base': base}
            }));
        print('response $response');
        if (response.statusCode != 200)
          throw HttpException('${response.statusCode}');

        ShowToast.info('All goodie', context);
      } catch (e) {
        ShowToast.error('Error has occured', context);
      }
//      http
//          .put('/api/project/123',
//              body: json.encode({
//                'airtable_credentials': {'api_key': token, 'base': base}
//              }))
//          .then((value) {
//        ShowToast.info('All goodie', context);
//      }).catchError(() {
//        ShowToast.error('Error has occured', context);
//        print('there is an errror');
//      });
      modal.close();
      print('kek lol 4eba $base, $token');
    }
  }

  Widget renderToken() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
                height: 425,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 40,
                    right: 20,
                    bottom: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add your API Key',
                        style: MyTextStyle.giantTitle,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'The API Key enables us to connect to your Airtable base and link your Airtable data to this app.',
                        style: MyTextStyle.regularTitle,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        placeholder: 'Paste your API key here',
                        value: token,
                        onChanged: (value) {
                          setState(() {
                            token = value;
                          });
                        },
                      ),
                      error.length > 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(error,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.error)),
                            )
                          : Container(),
                      Expanded(child: Container()),
                      MyButton(
                        text: 'Continue',
                        onTap: this.handleTokenContinue,
                      )
                    ],
                  ),
                )),
          ),
          Flexible(
            child: Container(
              height: 425,
              decoration: BoxDecoration(gradient: MyGradients.mainSuperLight),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 25, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'You\'ll find the API Key in your ',
                          style: MyTextStyle.regularTitle,
                        ),
                        MyLink(
                            text: 'Airtable Account page',
                            href: 'https://airtable.com/account')
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network('assets/icons/gif/token.gif')),
                    Expanded(
                      child: Container(),
                    ),
                    MyButton(
                      text: 'Open Airtable Account',
                      onTap: () {
                        js.context.callMethod(
                            'open', ['https://airtable.com/account']);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget renderBase() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
                height: 475,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 40,
                    right: 20,
                    bottom: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Share a Link to your Base',
                        style: MyTextStyle.giantTitle,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Choose the base that you use as a database for this app.\nPaste a link to this base.',
                        style: MyTextStyle.regularTitle,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        placeholder: 'Paste your Link here',
                        value: base,
                        onChanged: (value) {
                          setState(() {
                            base = value;
                          });
                        },
                      ),
                      error.length > 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(error,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.error)),
                            )
                          : Container(),
                      Expanded(child: Container()),
                      MyButton(
                        text: 'Continue',
                        onTap: this.handleBaseContinue,
                      )
                    ],
                  ),
                )),
          ),
          Flexible(
            child: Container(
              height: 475,
              decoration: BoxDecoration(gradient: MyGradients.mainSuperLight),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 25, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'You\'ll find this in the Share menu, which you can access from the top right-hand corner of your Airtable base'),
                    SizedBox(
                      height: 15,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network('assets/icons/gif/base.gif')),
                    Expanded(
                      child: Container(),
                    ),
                    MyButton(
                      text: 'Open Airtable',
                      onTap: () {
                        js.context.callMethod('open', ['https://airtable.com']);
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('isBase $isBase');

    return Column(
      children: [
        MyButton(
          text: 'Connect Airtable',
          icon: Image.network(
            'assets/icons/settings/airtable.svg',
            fit: BoxFit.contain,
            height: 17,
          ),
          onTap: () {
            modal.show(
                context: context,
                width: 980,
                height: 425,
                child: renderToken(),
                onClose: () {});
          },
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'You need to connect your Airtable base to synchronize the data with your App',
          style:
              TextStyle(color: Color(0xFF777777), fontSize: 14, height: 1.45),
        ),
      ],
    );
  }
}
