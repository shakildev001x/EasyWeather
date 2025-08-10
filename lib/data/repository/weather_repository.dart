import 'dart:convert';

import 'package:bloc_demo/data/data_provider/weather_data_provider.dart';
import 'package:bloc_demo/modesl/weather_model.dart';

class WeatherRepository {

  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getWeatherByCity(String cityName) async {

    final response = await weatherDataProvider.getWeatherByCity(cityName);

    if (response.statusCode == 200) {
     final data = jsonDecode(response.body);
     return WeatherModel.fromJson(data);
     
   } else {
      throw Exception("Failed to load weather data");
    }
  }



  Future<WeatherModel> getWeatherByLatLon() async {
    final response = await weatherDataProvider.getCurrentWeather();
   
   if (response.statusCode == 200) {
     final data = jsonDecode(response.body);
     return WeatherModel.fromJson(data);
     
   } else {
      throw Exception("Failed to load weather data");
    }
  }
  }


