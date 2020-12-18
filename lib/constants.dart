import 'package:flutter_app/app_skeleton/entities/skeleton_screen_size.dart';

class _BuilderConst {
  final double headerHeight = 60;
  const _BuilderConst();
}

const builderConst = _BuilderConst();

class _AppConst {
  /// minimal time to show loading animation
  final Duration minLoadingDuration = const Duration(milliseconds: 1250);

  const _AppConst();
}

/// application constants
const appConst = _AppConst();

/// iphoneX
const defaultSkeletonScreenSize = SkeletonScreenSize.iphoneX;
