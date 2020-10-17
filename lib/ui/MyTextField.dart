import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';

class MyTextField extends StatefulWidget {
  final String placeholder;
  final String defaultValue;
  final String value;
  final bool disabled;
  final Function onChanged;

  const MyTextField({
    Key key,
    this.placeholder,
    @required this.onChanged,
    this.defaultValue,
    this.value,
    this.disabled = false,
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
          padding:
              const EdgeInsets.only(top: 9, bottom: 8, left: 16, right: 16),
          style: MyTextStyle.regularTitle,
          placeholderStyle: MyTextStyle.regularTitle,
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
