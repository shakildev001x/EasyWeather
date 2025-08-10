class WeatherModel {
  final Location location;
  final CurrentWeather current;
  final List<ForecastDay> forecast;

  WeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
      current: CurrentWeather.fromJson(json['current']),
      forecast: (json['forecast']['forecastday'] as List)
          .map((e) => ForecastDay.fromJson(e))
          .toList(),
    );
  }
}

class Location {
  final String name;
  final String country;
  final String localtime;

  Location({
    required this.name,
    required this.country,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      country: json['country'],
      localtime: json['localtime'],
    );
  }
}

class CurrentWeather {
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final String conditionText;
  final String conditionIcon;
  final double windKph;
  final int humidity;
  final double feelsLikeC;
  final double feelsLikeF;
  final double uv;
  final double pressureMb;
  final double precipMm;
  final int cloud;

  CurrentWeather({
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.conditionText,
    required this.conditionIcon,
    required this.windKph,
    required this.humidity,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.uv,
    required this.pressureMb,
    required this.precipMm,
    required this.cloud,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      lastUpdated: json['last_updated'],
      tempC: (json['temp_c'] as num).toDouble(),
      tempF: (json['temp_f'] as num).toDouble(),
      conditionText: json['condition']['text'],
      conditionIcon: "https:${json['condition']['icon']}",
      windKph: (json['wind_kph'] as num).toDouble(),
      humidity: json['humidity'],
      feelsLikeC: (json['feelslike_c'] as num).toDouble(),
      feelsLikeF: (json['feelslike_f'] as num).toDouble(),
      uv: (json['uv'] as num).toDouble(),
      pressureMb: (json['pressure_mb'] as num).toDouble(),
      precipMm: (json['precip_mm'] as num).toDouble(),
      cloud: json['cloud'],
    );
  }
}

class ForecastDay {
  final String date;
  final double maxTempC;
  final double minTempC;
  final String conditionText;
  final String conditionIcon;
  final double uv;
  final String sunrise;
  final String sunset;
  final List<HourlyForecast> hourly;

  ForecastDay({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.conditionText,
    required this.conditionIcon,
    required this.uv,
    required this.sunrise,
    required this.sunset,
    required this.hourly,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date'],
      maxTempC: (json['day']['maxtemp_c'] as num).toDouble(),
      minTempC: (json['day']['mintemp_c'] as num).toDouble(),
      conditionText: json['day']['condition']['text'],
      conditionIcon: "https:${json['day']['condition']['icon']}",
      uv: (json['day']['uv'] as num).toDouble(),
      sunrise: json['astro']['sunrise'],
      sunset: json['astro']['sunset'],
      hourly: (json['hour'] as List)
          .map((e) => HourlyForecast.fromJson(e))
          .toList(),
    );
  }
}

class HourlyForecast {
  final String time;
  final double tempC;
  final String conditionText;
  final String conditionIcon;
  final int chanceOfRain;

  HourlyForecast({
    required this.time,
    required this.tempC,
    required this.conditionText,
    required this.conditionIcon,
    required this.chanceOfRain,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: json['time'],
      tempC: (json['temp_c'] as num).toDouble(),
      conditionText: json['condition']['text'],
      conditionIcon: "https:${json['condition']['icon']}",
      chanceOfRain: json['chance_of_rain'] ?? 0,
    );
  }
}
