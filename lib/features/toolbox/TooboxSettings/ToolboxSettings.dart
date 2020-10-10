import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/TooboxSettings/Theme/ToolboxTheme.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';

enum SettingsEnum { info, theme, terms }

class ToolboxSettings extends StatefulWidget {
  final UserActions userActions;

  const ToolboxSettings({Key key, this.userActions}) : super(key: key);

  @override
  _ToolboxSettingsState createState() => _ToolboxSettingsState();
}

class _ToolboxSettingsState extends State<ToolboxSettings>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  SettingsEnum selectedSetting;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: 1, vsync: this, duration: Duration(milliseconds: 250));
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuad,
      reverseCurve: Curves.easeInOutQuad,
    );
  }

  void selectSetting(SettingsEnum setting) {
    _controller.reverse();
    setState(() {
      selectedSetting = setting;
    });
  }

  void goBack() {
    _controller.forward();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        selectedSetting = null;
      });
    });
  }

  Widget buildItem(SettingsEnum setting) {
    Widget itemWidget;

    final defaultDecoration = BoxDecoration(
        gradient: MyGradients.plainWhite,
        borderRadius: BorderRadius.circular(8));
    final hoverDecoration = BoxDecoration(
        gradient: MyGradients.lightGray,
        borderRadius: BorderRadius.circular(8));

    if (setting == SettingsEnum.theme) {
      itemWidget = HoverDecoration(
        defaultDecoration: defaultDecoration,
        hoverDecoration: hoverDecoration,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 11, bottom: 11, right: 16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.network(
              'assets/icons/settings/theme.svg',
              width: 38,
              height: 38,
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme',
                  style: MyTextStyle.regularTitle,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "App colors",
                  style: MyTextStyle.regularCaption,
                ),
              ],
            )
          ]),
        ),
      );
    }
    return Cursor(
      cursor: CursorEnum.pointer,
      child: GestureDetector(
        onTap: () {
          selectSetting(setting);
        },
        child: itemWidget,
      ),
    );
  }

  Widget _buildMain() {
    return Column(
      children: [
        ToolboxTitle(
          'Settings',
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.0, left: 20, right: 10),
          child: Column(
            children: [buildItem(SettingsEnum.theme)],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedSetting() {
    return BuildToolboxThemePage(
        goBackToSettings: goBack, theme: widget.userActions.theme);
  }

  Widget buildMain(slideFirst, slideSecond) {
    return Stack(
      children: [
        Positioned(
          child: Transform(
              transform: Matrix4.identity()..translate(slideFirst),
              child: _animation.value < 0.4
                  ? Container()
                  : Container(
                      color: MyColors.white,
                      width: toolboxWidth,
                      child: _buildMain())),
        ),
        Positioned(
          child: Transform(
              transform: Matrix4.identity()..translate(slideSecond),
              child: _animation.value == 1
                  ? Container()
                  : Container(
                      color: MyColors.white,
                      width: toolboxWidth,
                      child: _buildSelectedSetting())),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxSlide = 300;

    return AnimatedBuilder(
      builder: (BuildContext context, Widget child) {
        double reversedValue = (_animation.value - 1) * -1;
        double slideFirst = (-maxSlide / 2) * reversedValue;
        double slideSecond = maxSlide * (_animation.value);

        if (_animation.value > 0.09 && _animation.value < 0.8) {
          return Container(
            child: ClipRect(
              child: buildMain(slideFirst, slideSecond),
            ),
          );
        }

        return Container(
          child: buildMain(slideFirst, slideSecond),
        );
      },
      animation: _animation,
    );
  }
}
