import 'dart:convert';

import 'package:bloc_demo/data/data_provider/get_current_location.dart';
import 'package:bloc_demo/data/data_provider/location_services.dart';
import 'package:bloc_demo/secrect.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherDataProvider {
  Future<http.Response> getCurrentWeather() async {
    Position position = await getCurrentLocation();
    String location = '${position.latitude},${position.longitude}';

     await LocationStorage.saveLocation(location);

    final uri = Uri.https('api.weatherapi.com', '/v1/forecast.json', {
      'key': Secrect.apiKey,
      'q': '${position.latitude},${position.longitude}',
      'days': '3',
      'aqi': 'no',
      'alerts': 'no',
    });

    try {
      final response = await http.get(uri).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }

  //  API call by city/district name
  Future<http.Response> getWeatherByCity(String cityName) async {
    await LocationStorage.saveLocation(cityName);
    final uri = Uri.https('api.weatherapi.com', '/v1/forecast.json', {
      'key': Secrect.apiKey,
      'q': cityName,
      'days': '3',
      'aqi': 'no',
      'alerts': 'no',
    });

    try {
      final response = await http.get(uri).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }
}
