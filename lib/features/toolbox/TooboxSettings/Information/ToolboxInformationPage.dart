import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';

class BuildToolboxInformationPage extends StatefulWidget {
  final Function goBackToSettings;
  final UserActions userActions;

  BuildToolboxInformationPage({
    @required this.goBackToSettings,
    @required this.userActions,
  });
  @override
  _BuildToolboxInformationPageState createState() => _BuildToolboxInformationPageState();
}

class _BuildToolboxInformationPageState extends State<BuildToolboxInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToolboxHeader(
            leftWidget: IconCircleButton(
                onTap: widget.goBackToSettings,
                assetPath: 'assets/icons/meta/btn-back.svg'),
            title: 'Information'),
        Padding(
          padding: EdgeInsets.only(top: 24.0, left: 20, right: 10),
          child: Container(),
        ),
      ],
    );
  }
}