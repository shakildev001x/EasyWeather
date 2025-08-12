part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class WeatherFetch extends WeatherEvent {}

final class WeatherChange extends WeatherEvent {
  final String typeName;
  WeatherChange(this.typeName);
}
class WeatherLoadSaved extends WeatherEvent {}