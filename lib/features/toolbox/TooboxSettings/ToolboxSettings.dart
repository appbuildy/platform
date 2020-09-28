import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/TooboxSettings/Theme/ToolboxTheme.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';

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

    if (setting == SettingsEnum.theme) {
      itemWidget = Container(
        color: Colors.transparent,
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
    return Column(
      children: [
        ToolboxHeader(
            leftWidget: IconCircleButton(
                onTap: goBack, assetPath: 'assets/icons/meta/btn-back.svg'),
            title: 'Theme'),
        Padding(
          padding: EdgeInsets.only(top: 24.0, left: 20, right: 10),
          child: ToolboxTheme(userActions: widget.userActions),
        ),
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

        return Stack(children: [
          Transform(
              transform: Matrix4.identity()..translate(slideFirst),
              child: _animation.value == 0
                  ? Container()
                  : Container(
                      color: MyColors.white,
                      width: toolboxWidth,
                      child: _buildMain())),
          Transform(
              transform: Matrix4.identity()..translate(slideSecond),
              child: _animation.value == 1
                  ? Container()
                  : Container(
                      color: MyColors.white,
                      width: toolboxWidth,
                      child: _buildSelectedSetting()))
        ]);
      },
      animation: _animation,
    );
  }
}
