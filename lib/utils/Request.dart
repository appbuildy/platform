import 'dart:convert';

import 'package:http/http.dart' as http;

class Request {
  Request.put(String url, Map<String, dynamic> body) {
//    headers['Content-type'] = 'application/json';
    http.put(url, body: json.encode(body));
  }
}
