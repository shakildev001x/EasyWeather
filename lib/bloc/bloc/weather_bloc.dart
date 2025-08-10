import 'package:bloc_demo/data/repository/weather_repository.dart';
import 'package:bloc_demo/modesl/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetch>(_getCurrentWeather);
    on<WeatherChange>(_getTypeWeather);
  }

  Future<void> _getCurrentWeather(
    WeatherFetch event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      WeatherModel weather;
      weather = await weatherRepository.getWeatherByLatLon();
      emit(WeatherSuccess(weather));
    } catch (e) {
      emit(WeatherFailer(e.toString()));
    }
  }

  Future<void> _getTypeWeather(
    WeatherChange event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      WeatherModel weather;
      weather = await weatherRepository.getWeatherByCity(event.typeName);
      print("Weather fetched for: ${event.typeName}");
      emit(WeatherSuccess(weather));
    } catch (e) {
       print("Error fetching weather: $e");
      emit(WeatherFailer(e.toString()));
    }
  }
}
