import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_app/utils/StringExtentions/ToColor.dart';

class HexColorField extends StatefulWidget {
  final bool withAlpha;

  final Color color;

  // final FocusNode hexFocus;

  final ValueChanged<Color> onColorChanged;

  const HexColorField({
    Key key,
    @required this.withAlpha,
    @required this.color,
    @required this.onColorChanged,
    // @required this.hexFocus,
  }) : super(key: key);

  @override
  _HexColorFieldState createState() => _HexColorFieldState();
}

class _HexColorFieldState extends State<HexColorField> {
  static const _width = 106.0;

  Color color;

  TextEditingController _controller;

  String prefix;

  int valueLength = 8;

  @override
  void initState() {
    super.initState();
    prefix = '#';

    valueLength = widget.withAlpha ? 8 : 6;

    String colorValue = _initColorValue();
    _controller = TextEditingController(text: colorValue);
  }

  @override
  void didUpdateWidget(HexColorField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      String colorValue = _initColorValue();
      _controller.text = colorValue;

      // if (widget.hexFocus.hasFocus) widget.hexFocus.nextFocus();
    }
  }

  String _initColorValue() {
    color = widget.color;
    var stringValue = color.value.toRadixString(16).padRight(8, '0');
    if (!widget.withAlpha) stringValue = stringValue.replaceRange(0, 2, '');
    return stringValue;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: SizedBox(
        width: _width,
        child: TextField(
          controller: _controller,
          // focusNode: widget.hexFocus,
          maxLines: 1,
          autocorrect: false,
          cursorColor: MyColors.black,
          autofocus: false,
          enableSuggestions: false,
          maxLength: valueLength,
          onChanged: (value) {
            if (value.length == valueLength)
              widget.onColorChanged(
                value.padRight(valueLength, '0').toColor(argb: widget.withAlpha),
              );
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[A-Fa-f0-9]')),
          ],
          decoration: InputDecoration(
            prefixText: prefix,
            counterText: '',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.borderGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.borderGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.borderGray),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          ),
        ),
      ),
    );
  }
}

class MyColorIndicator extends StatelessWidget {
  const MyColorIndicator(
      this.hsvColor, {
        this.width: 50.0,
        this.height: 50.0,
      });

  final HSVColor hsvColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(1000.0)),
        child: CustomPaint(painter: IndicatorPainter(hsvColor.toColor())),
      ),
    );
  }
}

class MyColorPicker extends StatefulWidget {
  const MyColorPicker({
    @required this.pickerColor,
    @required this.onColorChanged,
    @required this.orientation,
    this.paletteType: PaletteType.hsv,
    this.enableAlpha: true,
    this.showLabel: true,
    this.labelTextStyle,
    this.displayThumbColor: false,
    this.colorPickerWidth: 300.0,
    this.pickerAreaHeightPercent: 1.0,
    this.pickerAreaBorderRadius: const BorderRadius.all(Radius.zero),
  })  : assert(paletteType != null),
        assert(enableAlpha != null),
        assert(showLabel != null),
        assert(pickerAreaBorderRadius != null);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final Orientation orientation;
  final PaletteType paletteType;
  final bool enableAlpha;
  final bool showLabel;
  final TextStyle labelTextStyle;
  final bool displayThumbColor;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;
  final BorderRadius pickerAreaBorderRadius;

  @override
  _MyColorPickerState createState() => _MyColorPickerState();
}

class _MyColorPickerState extends State<MyColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);

  @override
  void initState() {
    super.initState();
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  @override
  void didUpdateWidget(MyColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  Widget colorPickerSlider(TrackType trackType) {
    return ColorPickerSlider(
      trackType,
      currentHsvColor,
          (HSVColor color) {
        setState(() => currentHsvColor = color);
        widget.onColorChanged(currentHsvColor.toColor());
      },
      displayThumbColor: widget.displayThumbColor,
    );
  }

  Widget colorPickerArea() {
    return ClipRRect(
      borderRadius: widget.pickerAreaBorderRadius,
      child: ColorPickerArea(
        currentHsvColor,
            (HSVColor color) {
          setState(() => currentHsvColor = color);
          widget.onColorChanged(currentHsvColor.toColor());
        },
        widget.paletteType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.orientation == Orientation.portrait) {
      return Column(
        children: <Widget>[
          SizedBox(
            width: widget.colorPickerWidth,
            height: widget.colorPickerWidth * widget.pickerAreaHeightPercent,
            child: colorPickerArea(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyColorIndicator(currentHsvColor),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                        width: widget.colorPickerWidth - 75.0,
                        child: colorPickerSlider(TrackType.hue),
                      ),
                      if (widget.enableAlpha)
                        SizedBox(
                          height: 40.0,
                          width: widget.colorPickerWidth - 75.0,
                          child: colorPickerSlider(TrackType.alpha),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.showLabel)
            ColorPickerLabel(
              currentHsvColor,
              enableAlpha: widget.enableAlpha,
              textStyle: widget.labelTextStyle,
            ),
          SizedBox(height: 20.0),
          HexColorField(
            color: currentHsvColor.toColor(),
            withAlpha: false,
            onColorChanged: (Color color) {
              setState(() {
                currentHsvColor = HSVColor.fromColor(color);
              });
              widget.onColorChanged(color);
            },
          ),
          SizedBox(height: 20.0),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              width: 300.0,
              height: 200.0,
              child: colorPickerArea(),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20.0),
                  MyColorIndicator(currentHsvColor),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                        width: 260.0,
                        child: colorPickerSlider(TrackType.hue),
                      ),
                      if (widget.enableAlpha)
                        SizedBox(
                          height: 40.0,
                          width: 260.0,
                          child: colorPickerSlider(TrackType.alpha),
                        ),
                    ],
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
              SizedBox(height: 20.0),
              if (widget.showLabel)
                ColorPickerLabel(
                  currentHsvColor,
                  enableAlpha: widget.enableAlpha,
                  textStyle: widget.labelTextStyle,
                ),
            ],
          ),
        ],
      );
    }
  }
}


class BuildColorPicker extends StatelessWidget {
  const BuildColorPicker({
    @required this.themeColor,
    @required this.onColorChange,
  });
  final Function onColorChange;
  final MyThemeProp themeColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: SingleChildScrollView(
        child: MyColorPicker(
          pickerColor: themeColor.color,
          onColorChanged: onColorChange,
          orientation: Orientation.portrait,
          colorPickerWidth: 300.0,
          enableAlpha: false,
          displayThumbColor: true,
          showLabel: true,
          paletteType: PaletteType.hsv,
          pickerAreaBorderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(2.0),
            topRight: const Radius.circular(2.0),
          ),
        ),
      ),
    );
  }
}