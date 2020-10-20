import 'package:flutter/material.dart';

double constrainPosition({
  @required double size,
  @required double value,
  @required double position,
  @required double max,
  bool isDisableWhenMin = false,
}) {
  if (isDisableWhenMin && size <= 30.0) {
    return position;
  }

  if (value + position <= 0) {
    return 0;
  } else if (value + position + size > max) {
    return (max - size);
  }

  return value + position;
}

double constrainSize({
  @required double size,
  @required double value,
  @required double position,
  @required double max,
  bool isSub = false,
  double prevPosition,
}) {
  final double realValue = isSub ? value * -1 : value;
  final int maxInt = max.round();

  if (isSub && position <= 0) {
    if (realValue < 0) {
      return size + realValue;
    }

    return size +
        prevPosition; // прыжок происходит потому что position уже поменялся и равен 0, а для сайза в таком случае value не прикладывается
  }

  if (size + realValue + position > maxInt) {
    return max - position;
  } else if (size + realValue <= 30.0) {
    return 30.0;
  }
  return size + realValue;
}