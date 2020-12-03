#!/bin/bash
PROJECT_URL=$1
curl -XGET $PROJECT_URL > build_data.dart
