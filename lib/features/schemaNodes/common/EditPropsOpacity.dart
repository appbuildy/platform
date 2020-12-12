import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/MySlider.dart';

class EditPropsOpacity extends StatelessWidget {
  final double value;
  final Function onChanged;

  const EditPropsOpacity(
      {Key key, @required this.value, @required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Opacity',
            style: MyTextStyle.regularCaption,
          ),
          SizedBox(width: 0),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: MySlider(
                    max: 1,
                    value: value,
                    onChanged: (double value) {
                      onChanged(num.parse(value.toStringAsFixed(2)));
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.right,
                    style: MyTextStyle.regularCaption,
                  ),
                ),
                SizedBox(width: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
