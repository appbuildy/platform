import 'package:universal_html/html.dart';

class SettingsParser {
  Window _window;
  SettingsParser(this._window);

  String get jwt =>
      _window.localStorage['jwt'] ?? Uri.base.queryParameters['jwt'];
  String get url =>
      _window.localStorage['url'] ?? Uri.base.queryParameters['url'];
  String get userUrl => "$url/me";
  String get projectId =>
      _window.localStorage['projectId'] ??
      Uri.base.queryParameters['project_id'];
  String get projectUrl => "$url/api/projects/$projectId";
}
