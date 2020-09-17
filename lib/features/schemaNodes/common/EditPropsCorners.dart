import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/MyColors.dart';

class EditPropsCorners extends StatelessWidget {
  final double value;
  final Function onChanged;

  const EditPropsCorners(
      {Key key, @required this.value, @required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Corners',
          style: MyTextStyle.regularCaption,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                      thumbColor: Colors.white,
                      overlayColor: Colors.transparent,
                      inactiveTrackColor: Color(0xffaab5c8),
                      activeTrackColor: MyColors.mainBlue,
                      trackHeight: 3),
                  child: Slider(
                    max: 0.5,
                    value: value / 100,
                    onChanged: (value) {
                      onChanged((value * 100).toInt());
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 24,
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
    );
  }
}
