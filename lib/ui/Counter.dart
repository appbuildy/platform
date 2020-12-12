import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';

class Counter extends StatefulWidget {
  final int initNumber;
  final String text;
  final bool canBeZero;
  final Function(int) counterCallback;
  final Function increaseCallback;
  final Function decreaseCallback;
  Counter(
      {this.initNumber,
      this.counterCallback,
      this.increaseCallback,
      this.decreaseCallback,
      this.text = '',
      this.canBeZero = false});
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _currentCount;
  Function _counterCallback;
  Function _increaseCallback;
  Function _decreaseCallback;

  @override
  void initState() {
    _currentCount = widget.initNumber ?? 1;
    _counterCallback = widget.counterCallback ?? (int number) {};
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: MyGradients.plainWhite,
          border: Border.all(width: 1, color: MyColors.borderGray)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1, color: MyColors.borderGray))),
              child: _createIncrementDecrementButton(
                  Icons.remove, () => _decrement())),
          Text('${_currentCount.toString()} ${widget.text}'),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 1, color: MyColors.borderGray))),
              child: _createIncrementDecrementButton(
                  Icons.add, () => _increment())),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      _currentCount++;
      _counterCallback(_currentCount);
      _increaseCallback();
    });
  }

  void _decrement() {
    setState(() {
      if (widget.canBeZero ? _currentCount > 0 : _currentCount > 1) {
        _currentCount--;
        _counterCallback(_currentCount);
        _decreaseCallback();
      }
    });
  }

  Widget _createIncrementDecrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      onPressed: onPressed,
      elevation: 2.0,
      child: Icon(
        icon,
        color: MyColors.iconDarkGray,
        size: 16.0,
      ),
    );
  }
}
