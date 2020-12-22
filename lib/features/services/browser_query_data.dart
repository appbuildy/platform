import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart';

class BrowserQueryData extends InheritedWidget {
  static const String _mainHost = "https://www.appbuildy.com";

  final Window window;
  const BrowserQueryData({this.window, Widget child}) : super(child: child);

  String get url =>
      window.localStorage['url'] ??
      Uri.base.queryParameters['url'] ??
      _mainHost;

  String get userUrl => "$url/me";

  /// json web token
  String get jwt =>
      window.localStorage['jwt'] ?? Uri.base.queryParameters['jwt'];

  /// opened project id
  String get projectId =>
      window.localStorage['projectId'] ??
      Uri.base.queryParameters['project_id'];

  /// opened project url
  String get projectUrl => "$url/api/projects/$projectId";

  /// show app preview instead of app builder
  bool get isPreview => Uri.base?.queryParameters['preview_mode'] == 'enabled';

  @override
  bool updateShouldNotify(BrowserQueryData oldWidget) {
    return oldWidget.window != window ||
        oldWidget.jwt != jwt ||
        oldWidget.projectId != projectId;
  }

  static BrowserQueryData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BrowserQueryData>();
  }
}
