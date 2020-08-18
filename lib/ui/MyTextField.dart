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
  void didUpdateWidget(MyTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _textEditingController.value = TextEditingValue(
      text: widget.defaultValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: widget.defaultValue.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onChanged: (String value) {
        widget.onChanged(value);
      },
      enableInteractiveSelection: true,
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        fontFamily: 'ObjectSans',
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      cursorRadius: Radius.circular(0),
    );
  }
}
