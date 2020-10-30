import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/toolbox/TooboxSettings/Airtable/ToolboxAirtablePage.dart';
import 'package:flutter_app/features/toolbox/TooboxSettings/Information/ToolboxInformationPage.dart';
import 'package:flutter_app/features/toolbox/TooboxSettings/Theme/ToolboxThemePage.dart';
import 'package:flutter_app/features/toolbox/ToolboxUI.dart';
import 'package:flutter_app/ui/Cursor.dart';
import 'package:flutter_app/ui/HoverDecoration.dart';
import 'package:flutter_app/ui/MyColors.dart';
import 'package:flutter_app/ui/PageSliderAnimator.dart';

enum SettingsEnum { information, theme, airtable, terms }

class ToolboxSettings extends StatefulWidget {
  final UserActions userActions;

  const ToolboxSettings({Key key, this.userActions}) : super(key: key);

  @override
  _ToolboxSettingsState createState() => _ToolboxSettingsState();
}

class _ToolboxSettingsState extends State<ToolboxSettings>
    with SingleTickerProviderStateMixin {
  PageSliderController pageSliderController;

  @override
  void initState() {
    super.initState();

    Map<SettingsEnum, BuildWidgetFunction> sliderAnimationPages = {
      SettingsEnum.information: () => BuildToolboxInformationPage(goBackToSettings: goBack, userActions: widget.userActions),
      SettingsEnum.theme: () => BuildToolboxThemePage(goBackToSettings: goBack, userActions: widget.userActions),
      SettingsEnum.airtable: () => BuildToolboxAirtablePage(goBackToSettings: goBack, userActions: widget.userActions),
    };

    pageSliderController = PageSliderController<SettingsEnum>(
      vsync: this,
      rootPage: _buildMain,
      pagesMap: sliderAnimationPages,
    );
  }

  void selectSetting(SettingsEnum setting) {
    pageSliderController.to(setting);
  }

  void goBack() {
    pageSliderController.toRoot();
  }

  Widget buildItem(SettingsEnum setting) {
    Widget itemWidget;

    if (setting == SettingsEnum.information) {
      itemWidget = BuildThemeToolboxItem(
        iconPath: 'assets/icons/settings/information.svg',
        title: 'Information',
        subtitle: "Name, icon and description",
      );
    }

    if (setting == SettingsEnum.theme) {
      itemWidget = BuildThemeToolboxItem(
        iconPath: 'assets/icons/settings/theme.svg',
        title: 'Theme',
        subtitle: "App colors",
      );
    }

    if (setting == SettingsEnum.airtable) {
      itemWidget = BuildThemeToolboxItem(
        iconPath: 'assets/icons/settings/airtable.svg',
        title: 'Airtable',
        subtitle: 'Data connection',
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
            children: [
              buildItem(SettingsEnum.information),
              buildItem(SettingsEnum.theme),
              buildItem(SettingsEnum.airtable),
            ],
          ),
        ),
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

class BuildThemeToolboxItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;

  BuildThemeToolboxItem({
    this.iconPath,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = BoxDecoration(
        gradient: MyGradients.plainWhite,
        borderRadius: BorderRadius.circular(8));
    final hoverDecoration = BoxDecoration(
        gradient: MyGradients.lightGray,
        borderRadius: BorderRadius.circular(8));
    return HoverDecoration(
      defaultDecoration: defaultDecoration,
      hoverDecoration: hoverDecoration,
      child: Container(
        height: 70.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                iconPath,
                width: 38,
                height: 38,
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: MyTextStyle.regularTitle,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    subtitle,
                    style: MyTextStyle.regularCaption,
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}
