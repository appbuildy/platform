import 'package:flutter/material.dart';
import 'package:flutter_app/config/colors.dart';

class MySlider extends StatelessWidget {
  final double value;
  final Function onChanged;
  final double min;
  final double max;

  const MySlider(
      {Key key,
      @required this.value,
      @required this.onChanged,
      this.min = 0.0,
      this.max = 1.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: SliderTheme(
        data: SliderThemeData(
            thumbColor: Colors.white,
            overlayColor: Colors.transparent,
            inactiveTrackColor: Color(0xffaab5c8),
            activeTrackColor: MyColors.mainBlue,
            trackHeight: 3),
        child: Slider(
          min: min,
          max: max,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
