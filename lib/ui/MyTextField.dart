import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String placeholder;
  final String defaultValue;
  final Function onChanged;

  const MyTextField({
    Key key,
    this.placeholder,
    @required this.onChanged,
    this.defaultValue,
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
      suffix: Padding(
        padding: const EdgeInsets.only(right: 20),
      ),
      suffixMode: OverlayVisibilityMode.always,
      placeholder: widget.placeholder,
      textCapitalization: TextCapitalization.sentences,
      padding: EdgeInsets.only(
        left: 20,
        top: 23,
        bottom: 20,
        right: 20,
      ),
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        fontFamily: 'ObjectSans',
        color: Colors.black,
      ),
      placeholderStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        fontFamily: 'ObjectSans',
        color: Colors.grey,
      ),
      cursorColor: Colors.black,
      cursorRadius: Radius.circular(0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1)),
    );
  }
}
