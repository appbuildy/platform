import 'package:flutter/material.dart';
import 'package:flutter_app/features/entities/Project.dart';

import 'app_skeleton/loading/application_loaded_from_json.dart';
import 'build_data.dart' as data;

void main() {
  var project = Project.fromJson(data.canvas);
  runApp(ApplicationLoadedFromJson(project).load());
}
