import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/colors.dart';
import 'package:flutter_app/config/text_styles.dart';

class MyTextField extends StatefulWidget {
  final String placeholder;
  final String defaultValue;
  final String value;
  final bool disabled;
  final Function onChanged;
  final maxLines;

  const MyTextField({
    Key key,
    this.placeholder,
    @required this.onChanged,
    this.defaultValue,
    this.value,
    this.disabled = false,
    this.maxLines,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.defaultValue ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.disabled,
      child: CupertinoTextField(
          maxLength: 240,
          controller: _textEditingController,
          onChanged: (String value) {
            widget.onChanged(value);
          },
          enableInteractiveSelection: true,
          placeholder: widget.placeholder,
          maxLines: widget.maxLines,
          padding:
              const EdgeInsets.only(top: 9, bottom: 8, left: 16, right: 16),
          style: MyTextStyle.regularTitle,
          placeholderStyle: TextStyle(
              color: Color(0xFF777777),
              fontSize: 16,
              fontWeight: FontWeight.w500),
          cursorColor: MyColors.black,
          cursorRadius: Radius.circular(0),
          decoration: widget.disabled
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: MyGradients.buttonDisabledGray,
                  border: Border.all(
                      width: 1, color: Color(0xFF666666).withOpacity(0.3)))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: MyColors.white,
                  border: Border.all(width: 1, color: MyColors.borderGray))),
    );
  }
}
