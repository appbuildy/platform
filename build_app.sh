#!/bin/bash
PROJECT_URL=$1
curl -XGET $PROJECT_URL > lib/build_data.dart
flutter build ios -t lib/build_main.dart --no-tree-shake-icons 
