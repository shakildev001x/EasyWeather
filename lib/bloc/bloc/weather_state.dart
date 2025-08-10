part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherFailer extends WeatherState {
  final String error;
  WeatherFailer(this.error);
}

final class WeatherSuccess extends WeatherState {
  final WeatherModel weatherModel;
  WeatherSuccess(this.weatherModel);
}

final class WeatherLoading extends WeatherState {}

