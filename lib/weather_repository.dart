import 'package:appdotempo/weather.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Weather> getWeather() async {
  final String url = 'https://api.hgbrasil.com/weather?key=53493574';

  final response = await http.get(url);

  if(response.statusCode == 200) {
    print(response.body);
    return Weather.fromJson(json.decode(response.body));
  } else {
    throw Exception("Erro");
  }
}