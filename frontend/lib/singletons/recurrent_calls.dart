import 'dart:async';
import 'package:http/http.dart' as http;

class Endpoint {
  String uri;
  int requests_per_second = 1;

  Endpoint(this.uri);
}

final List<Endpoint> ENDPOINTS = [
  Endpoint("/api/"),
  Endpoint("/api/hello"),
  Endpoint("/api/delayed")
];

class RecurrentCalls {
  static void init() {
    Timer.periodic(
      const Duration(seconds: 1),
      _do_requests
    );
  }

  static void _do_requests(Timer t) {
    for (var endpoint in ENDPOINTS) {

      final url = Uri.http("localhost:8181", endpoint.uri);
      for (var i = 0; i < endpoint.requests_per_second; i++) {
        http.get(url);
      }
    }
  }
}

