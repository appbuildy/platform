import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/colors.dart';
import 'package:flutter_app/ui/MySlider.dart';

class EditPropsCorners extends StatelessWidget {
  final double value;
  final Function onChanged;

  const EditPropsCorners(
      {Key key, @required this.value, @required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Corners',
            style: MyTextStyle.regularCaption,
          ),
          SizedBox(width: 0),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: MySlider(
                    max: 0.5,
                    value: value / 100,
                    onChanged: (value) {
                      onChanged((value * 100).toInt());
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
