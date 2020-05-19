import 'dart:convert';
import 'package:http/http.dart' as http;

String baseUrl = "http://127.0.0.1:8080";

/// Get request from url
/// Return future of data


Future<List<dynamic>> getRequest(String url) async {

  // Call request with corresponded headers
    final response = await http.get(baseUrl + url, headers: {},);
    print(response.statusCode);
    print(response.reasonPhrase);
    return json.decode(response.body);
}

