import 'package:universal_html/html.dart';

class ProjectParametersFromBrowserQuery {
  Window _window;
  ProjectParametersFromBrowserQuery(this._window);
  static const String mainHost = "https://www.appbuildy.com";

  bool isPreviewMode = Uri.base.queryParameters['preview_mode'] == 'enabled';
  String get jwt =>
      _window.localStorage['jwt'] ?? Uri.base.queryParameters['jwt'];
  String get url =>
      _window.localStorage['url'] ??
      Uri.base.queryParameters['url'] ??
      mainHost;
  String get userUrl => "$url/me";
  String get projectId =>
      _window.localStorage['projectId'] ??
      Uri.base.queryParameters['project_id'];

  String get projectUrl => "$url/api/projects/$projectId";
}
