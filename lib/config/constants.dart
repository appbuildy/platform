import 'package:flutter_app/app_skeleton/entities/skeleton_screen_size.dart';

class _AppConst {
  /// minimal time to show loading animation
  final Duration minLoadingDuration = const Duration(milliseconds: 1250);

  /// animation box square side length
  final double loaderLogoSize = 150;

  const _AppConst();
}

/// application constants
const appConst = _AppConst();

class _BuilderConst {
  final double headerHeight = 60;
  final double toolboxWidth = 311.0;
  const _BuilderConst();
}

const builderConst = _BuilderConst();

/// iphoneX
const defaultSkeletonScreenSize = SkeletonScreenSize.iphoneX;
