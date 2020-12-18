import 'package:flutter/foundation.dart';
import 'package:flutter_app/app_skeleton/entities/skeleton_screen_size.dart';
import 'package:flutter_app/app_skeleton/widgets/bottom_navigation.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/utils/RandomKey.dart';

//! renamed, cause there is screen class in framework,
//!  changed to simple data class
class SkeletonScreen {
  // final Map<String, dynamic> _jsonScreen;

  /// screen id
  final RandomKey id;

  /// props of layout from builder
  final SkeletonScreenSize screenSize;

  /// body layout
  final List<WidgetDecorator> widgets;

  /// bottom navigation bar, if any
  final BottomNavigation navBar;
  bool get showNavBar => navBar != null;

  SkeletonScreen({
    this.id,
    @required this.widgets,
    this.navBar,
    this.screenSize = defaultSkeletonScreenSize,
  });

  /// parse jsonified widgets data
  factory SkeletonScreen.fromJson({
    Map<String, dynamic> json,
    BottomNavigation navBar,
    //? this one is dead for now i guess??
    Project project,
  }) {
    return SkeletonScreen(
      id: RandomKey.fromJson(json['id']),
      widgets: json['components']
          .map<WidgetDecorator>(
            (component) => WidgetDecorator.fromJson(component),
          )
          .toList(),
      navBar: navBar,
    );
  }

  factory SkeletonScreen.fromProject(
    Project project, {
    BottomNavigation navBar,
  }) {
    return SkeletonScreen.fromJson(
      json: project.data,
      navBar: navBar,
    );
  }
  // return ScreenLoadFromJson(jsonScreen).load(
  //   bottomNavigation,
  //   project,
  // );
  // @override
  // SkeletonScreen load([bottomNavigation, project]) {
  //   return SkeletonScreen(
  //       navBar: bottomNavigation, id: _id(), widgets: _loadWidgets());
  // }

  // @override
  // Widget build(BuildContext context) {
  //   //! we could just add conditional in the column builder
  //   // var nav = bottomNavigation ?? Container();

  //   //! made global constants instead
  //   // double screenHeightInConstructor = 812;
  //   // double screenWidthInConstructor = 375;

  //   //! better and more reliable to use LayoutBuilder here
  //   // var currentScreenSize = MediaQuery.of(context).size;

  //   // double screenHeight = currentScreenSize.height;
  //   // double screenWidth = currentScreenSize.width;

  //   //! there is a  FittedBox widget which actually scales its content to fill
  //   //! availalbe space
  //   // double scaleFactor = screenWidth / screenWidthInConstructor;

  //   //! got em from constants
  //   // final double navHeight = 84;

  //   // final double heightWithoutNavigationFromConstructor =
  //   //     (screenHeightInConstructor - navHeight) * scaleFactor;
  //   // final double heightWithoutNavigationFromCurrentScreen =
  //   //     screenHeight - navHeight;

  //   return Scaffold(
  //     body: Column(
  //       //! why start when we want to stretch content to fill the screen?
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         //! expanded fixes size to all available space that is left after
  //         //! other children laid themselves
  //         Expanded(
  //           child: SingleChildScrollView(
  //             //! added this so we have constrained box
  //             child: AspectRatio(
  //               aspectRatio: showNavBar
  //                   ? defaultScreenSize.bodyAspectRatio
  //                   : defaultScreenSize.boxAspectRatio,
  //               //! scales to fit given constraints
  //               child: FittedBox(
  //                 fit: BoxFit.fitWidth,
  //                 //! coords will be exactly as in build screen
  //                 child: SizedBox(
  //                   width: defaultScreenSize.boxWidth,
  //                   height: showNavBar
  //                       ? defaultScreenSize.bodyHeight
  //                       : defaultScreenSize.boxHeight,
  //                   child: Stack(
  //                     clipBehavior: Clip.none,
  //                     //! empty stack should still be fine
  //                     children: widgets ?? [],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         //! bottom navigator stretched to fill the whole width
  //         if (showNavBar) navBar,
  //       ],
  //     ),
  //   );
  // }
}
