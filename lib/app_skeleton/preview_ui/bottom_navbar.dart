import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/entities/skeleton_entities.dart';
import 'package:flutter_app/app_skeleton/preview_ui/state/preview_state_store.dart';
import 'package:flutter_app/features/appPreview/AppTabs.dart';
import 'package:flutter_app/store/userActions/AppThemeStore/MyThemes.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  final SkeletonNavBar navBarData;
  final double width;
  final double height;
  const BottomNavBar({this.width, this.height, this.navBarData});

  @override
  Widget build(BuildContext context) {
    var theme = MyThemes.allThemes['blue'];
    final store = Provider.of<PreviewStateStore>(context);
    return Positioned(
      bottom: 0,
      left: 0,
      width: width,
      height: height,
      child: Column(children: [
        Divider(
          color: theme.separators.color,
          thickness: 1,
        ),
        Expanded(
          child: AppTabs(
            selectedScreenId: store.currentScreenKey,
            tabs: navBarData.tabs,
            theme: theme,
            onTap: (tab) {
              store.setCurrentScreen(newScreenKey: tab.target);
            },
          ),
        )
      ]),
    );
  }
}
