import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'ToolboxThemeItem.dart';
import 'ToolboxThemeItemSettings/ToolboxThemeItemColorSelect.dart';

class BuildToolboxThemePage extends StatefulWidget {
  final goBackToSettings;
  final UserActions userActions;

  BuildToolboxThemePage({
    @required this.goBackToSettings,
    @required this.userActions,
  });

  @override
  _BuildToolboxThemePageState createState() => _BuildToolboxThemePageState();
}

class _BuildToolboxThemePageState extends State<BuildToolboxThemePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  MyTheme selectedTheme;

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

  void selectTheme(MyTheme theme) {
    _controller.reverse();
    widget.userActions.setTheme(theme);
    setState(() {
      selectedTheme = theme;
    });
  }

  void goBack() {
    _controller.forward();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        selectedTheme = null;
      });
    });
  }

  Widget _buildMain() {
    return Column(
      children: [
        ToolboxHeader(
            leftWidget: IconCircleButton(
                onTap: widget.goBackToSettings,
                assetPath: 'assets/icons/meta/btn-back.svg'),
            title: 'Theme'),
        Padding(
          padding: EdgeInsets.only(top: 24.0, left: 20, right: 10),
          child: ToolboxThemeItems(
            userActions: widget.userActions,
            onThemeSettingsTap: selectTheme,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedThemeItemSettings() {
    if (selectedTheme == null) return null;

    onColorChange(String oldColorName) {
      return (Color newColor) {
        widget.userActions.currentTheme.getThemePropByName(oldColorName).color =
            newColor;
        widget.userActions.setTheme(widget.userActions.currentTheme);
        setState(() {
          selectedTheme = widget.userActions.currentTheme;
        });
      };
    }

    return Column(
      children: [
        ToolboxHeader(
          leftWidget: IconCircleButton(
              onTap: goBack, assetPath: 'assets/icons/meta/btn-back.svg'),
          title: selectedTheme.name,
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.0, left: 20, right: 20),
          child: Column(
            children: selectedTheme.getAllColors().map((MyThemeProp color) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: BuildColorSelect(
                  themeColor: color,
                  onColorChange: onColorChange(color.name),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget buildMain(slideFirst, slideSecond) {
    return Stack(
      overflow: Overflow.clip,
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned(
          child: Transform(
            transform: Matrix4.identity()..translate(slideFirst),
            child: _animation.value == 0
                ? Container()
                : Container(width: toolboxWidth, child: _buildMain()),
          ),
        ),
        Positioned(
          child: Transform(
            transform: Matrix4.identity()..translate(slideSecond),
            child: _animation.value == 1
                ? Container()
                : Container(
                    width: toolboxWidth,
                    child: _buildSelectedThemeItemSettings()),
          ),
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

class ToolboxThemeItems extends StatelessWidget {
  final UserActions userActions;
  final Function onThemeSettingsTap;

  const ToolboxThemeItems({
    Key key,
    @required this.userActions,
    @required this.onThemeSettingsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        final currentTheme = userActions.currentTheme;

        return Column(
          children: MyThemes.allThemes.values.map((MyTheme themeItem) {
            return ToolboxThemeItem(
              theme: themeItem,
              isActive: currentTheme.name == themeItem.name,
              setTheme: userActions.setTheme,
              onSettingsTap: onThemeSettingsTap,
            );
          }).toList(),
        );
      },
    );
  }
}
