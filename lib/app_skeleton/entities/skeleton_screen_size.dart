/// screen size data of the skeleton app
class SkeletonScreenSize {
  /// iphone X screen size
  static const iphoneX = const SkeletonScreenSize(
    boxHeight: 812,
    boxWidth: 375,
    navBarHeight: 82,
  );

  /// height of whole screen
  final double boxHeight;

  /// width of whole screen
  final double boxWidth;

  /// aspect ratio of the screen
  double get boxAspectRatio => boxWidth / boxHeight;

  /// height of the screen except the navbar
  double get bodyHeight => boxHeight - navBarHeight;

  /// width of the screen except the navbar
  double get bodyWidth => boxWidth;

  /// aspect ratio og the screen except navbar
  double get bodyAspectRatio => bodyWidth / bodyHeight;

  final double navBarHeight;
  double get navBarWidth => boxWidth;
  double get navBarAspectRatio => navBarWidth / navBarHeight;

  const SkeletonScreenSize({
    this.boxHeight,
    this.boxWidth,
    this.navBarHeight,
  });
}
