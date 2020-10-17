import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';

class MyTextField extends StatefulWidget {
  final String placeholder;
  final String defaultValue;
  final String value;
  final Function onChanged;
  final bool enabled;

  const MyTextField({
    Key key,
    this.placeholder,
    @required this.onChanged,
    this.defaultValue,
    this.value,
    this.enabled = true,
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
    return CupertinoTextField(
        maxLength: 240,
        controller: _textEditingController,
        onChanged: (String value) {
          widget.onChanged(value);
        },
        enableInteractiveSelection: true,
        placeholder: widget.placeholder,
        padding: const EdgeInsets.only(top: 9, bottom: 8, left: 16, right: 16),
        style: MyTextStyle.regularTitle,
        placeholderStyle: MyTextStyle.regularTitle,
        cursorColor: MyColors.black,
        cursorRadius: Radius.circular(0),
        enabled: widget.enabled,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: MyColors.white,
            border: Border.all(width: 1, color: MyColors.borderGray)));
  }
}
