import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyTextField.dart';
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
  Widget _buildTextField({
    String title,
    String textFieldDefaultValue,
    Function onTextFieldChange,
    String textFieldPlaceholder,
    int maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Color(0xFF777777), fontSize: 16)),
        SizedBox(height: 7.0),
        MyTextField(
          defaultValue: textFieldDefaultValue,
          onChanged: onTextFieldChange,
          placeholder: textFieldPlaceholder,
          maxLines: maxLines,
          disabled: true,
        ),
      ],
    );
  }

  // Widget _buildIconChange() {
  //   return Column(
  //     children: [
  //       Text('App Icon', style: MyTextStyle.regularTitle.copyWith(fontWeight: FontWeight.w500)),
  //       SizedBox(height: 13.0),
  //       Image.network(
  //         'assets/icons/settings/information.svg',
  //         width: 72,
  //         height: 72,
  //         fit: BoxFit.fill,
  //       ),
  //       SizedBox(height: 13.0),
  //       Row(
  //         children: [
  //           _buildButton(text: 'Upload'),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildButton({
  //   String text,
  //   String icon,
  //   Function onTap,
  //   bool invert = false,
  // }) {
  //   return Cursor(
  //     cursor: CursorEnum.pointer,
  //     child: GestureDetector(
  //       onTap: onTap,
  //       child: HoverOpacity(
  //         child: Container(
  //           decoration: BoxDecoration(
  //               gradient: MyGradients.mainBlue,
  //               borderRadius: BorderRadius.circular(6),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 4, bottom: 6, left: 12, right: 12),
  //             child: Text(
  //               text,
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: MyColors.textBlue,
  //                 fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
          padding: EdgeInsets.only(top: 24.0, left: 20, right: 20),
          child: Container(
            child: Column(
              children: [
                _buildTextField(
                  title: 'App Name',
                  onTextFieldChange: () {},
                  textFieldDefaultValue: widget.userActions.currentUserStore.project?.data['name'] ?? '',
                  textFieldPlaceholder: 'Untitled'
                ),
                SizedBox(height: 17.0),
                _buildTextField(
                  title: 'Description',
                  onTextFieldChange: () {},
                  textFieldDefaultValue: '',
                  textFieldPlaceholder: 'What is that app for?',
                  maxLines: 3,
                ),
                //SizedBox(height: 24.0),
                //_buildIconChange(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}