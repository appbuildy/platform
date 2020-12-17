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

class _PhoneConst {
  final double phoneBoxHeight = 812;
  final double phoneBoxWidth = 375;
  final double navBarHeight = 82;
  double get bodyHeight => phoneBoxHeight - navBarHeight;
  double get phoneBoxAspectRatio => phoneBoxWidth / phoneBoxHeight;
  double get bodyAspectRatio => phoneBoxWidth / bodyHeight;

  const _PhoneConst();
}

/// appbuildy preview constants
const screenConst = _PhoneConst();
