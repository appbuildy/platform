import 'package:flutter/material.dart';

import 'app_skeleton/loading/application_loaded_from_json.dart';
import 'build_data.dart' as data;

void main() {
  runApp(ApplicationLoadedFromJson(data.data).load());
}
