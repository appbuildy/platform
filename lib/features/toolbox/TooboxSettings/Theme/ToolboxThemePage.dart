import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:flutter_app/ui/IconCircleButton.dart';
import 'package:flutter_app/ui/ToolboxHeader.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_app/ui/PageSliderAnimator.dart';

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

  PageSliderController pageSliderController;

  @override
  void initState() {
    super.initState();

    Map<String, Widget> sliderAnimationPages = {};

    MyThemes.allThemes.forEach((String key, MyTheme value) {
      sliderAnimationPages[key] = _buildThemeItemSettings(key);
    });

    pageSliderController = PageSliderController<String>(
        vsync: this,
        rootPage: _buildMain(),
        pagesMap: sliderAnimationPages,
    );
  }

  void selectTheme(String theme) {
    widget.userActions.setTheme(MyThemes.allThemes[theme]);
    pageSliderController.to(theme);
  }

  void goBack() {
    pageSliderController.toRoot();
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

  Widget _buildThemeItemSettings(String themeKey) {
    final theme = MyThemes.allThemes[themeKey];

    onColorChange(String oldColorName) {
      return (Color newColor) {
        widget.userActions.currentTheme.getThemePropByName(oldColorName).color =
            newColor;
        widget.userActions.setTheme(widget.userActions.currentTheme);
        setState(() {
          pageSliderController.updatePage(themeKey, _buildThemeItemSettings(themeKey));
        });
      };
    }

    return Column(
      children: [
        ToolboxHeader(
          leftWidget: IconCircleButton(
              onTap: goBack, assetPath: 'assets/icons/meta/btn-back.svg'),
          title: theme.name,
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.0, left: 20, right: 20),
          child: Column(
            children: theme.getAllColors().map((MyThemeProp color) {
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

  @override
  Widget build(BuildContext context) {
    return PageSliderAnimator(
      pageSliderController: pageSliderController,
      maxSlide: 300,
      slidesWidth: 311,
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
          children: MyThemes.allThemes.keys.map((String key) {
            final theme = MyThemes.allThemes[key];

            return ToolboxThemeItem(
              theme: theme,
              isActive: currentTheme.name == theme.name,
              setTheme: userActions.setTheme,
              onSettingsTap: () => onThemeSettingsTap(key),
            );
          }).toList(),
        );
      },
    );
  }
}
