import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiWeatherController {
  void testApi() async {
    http.Response response = await http.get("https://api.hgbrasil.com/weather");
    Map parsedJson = json.decode(response.body);
    if (response.statusCode != 200) {}
  }
}
