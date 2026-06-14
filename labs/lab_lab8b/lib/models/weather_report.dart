import 'city_location.dart';

class WeatherReport {
  final CityLocation location;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final double precipitation;
  final double rain;
  final int weatherCode;
  final double todayMaxTemp;
  final double todayMinTemp;
  final int precipitationProbability;

  const WeatherReport({
    required this.location,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.precipitation,
    required this.rain,
    required this.weatherCode,
    required this.todayMaxTemp,
    required this.todayMinTemp,
    required this.precipitationProbability,
  });

  factory WeatherReport.fromJson({
    required CityLocation location,
    required Map<String, dynamic> json,
  }) {
    final current = json['current'] as Map<String, dynamic>?;
    final daily = json['daily'] as Map<String, dynamic>?;

    if (current == null || daily == null) {
      throw const FormatException('Unexpected weather response structure');
    }

    return WeatherReport(
      location: location,
      temperature: _toDouble(current['temperature_2m']),
      feelsLike: _toDouble(current['apparent_temperature']),
      humidity: _toInt(current['relative_humidity_2m']),
      windSpeed: _toDouble(current['wind_speed_10m']),
      precipitation: _toDouble(current['precipitation']),
      rain: _toDouble(current['rain']),
      weatherCode: _toInt(current['weather_code']),
      todayMaxTemp: _toDoubleFromList(daily['temperature_2m_max']),
      todayMinTemp: _toDoubleFromList(daily['temperature_2m_min']),
      precipitationProbability: _toIntFromList(daily['precipitation_probability_max']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return 0;
  }

  static int _toInt(dynamic value) {
    if (value is num) return value.toInt();
    return 0;
  }

  static double _toDoubleFromList(dynamic value) {
    if (value is List && value.isNotEmpty && value.first is num) {
      return (value.first as num).toDouble();
    }
    return 0;
  }

  static int _toIntFromList(dynamic value) {
    if (value is List && value.isNotEmpty && value.first is num) {
      return (value.first as num).toInt();
    }
    return 0;
  }

  String get weatherDescription {
    if (weatherCode == 0) return 'Clear sky';
    if (weatherCode == 1 || weatherCode == 2 || weatherCode == 3) {
      return 'Partly cloudy';
    }
    if (weatherCode == 45 || weatherCode == 48) return 'Foggy';
    if ([51, 53, 55, 56, 57].contains(weatherCode)) return 'Drizzle';
    if ([61, 63, 65, 66, 67].contains(weatherCode)) return 'Rainy';
    if ([71, 73, 75, 77].contains(weatherCode)) return 'Snowy';
    if ([80, 81, 82].contains(weatherCode)) return 'Rain showers';
    if ([95, 96, 99].contains(weatherCode)) return 'Thunderstorm';
    return 'Unknown weather';
  }

  String get weatherIcon {
    if (weatherCode == 0) return '☀️';
    if (weatherCode == 1 || weatherCode == 2 || weatherCode == 3) return '⛅';
    if (weatherCode == 45 || weatherCode == 48) return '🌫️';
    if ([51, 53, 55, 56, 57].contains(weatherCode)) return '🌦️';
    if ([61, 63, 65, 66, 67, 80, 81, 82].contains(weatherCode)) return '🌧️';
    if ([71, 73, 75, 77].contains(weatherCode)) return '❄️';
    if ([95, 96, 99].contains(weatherCode)) return '⛈️';
    return '🌤️';
  }

  String get umbrellaAdvice {
    final rainyCode = [51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82, 95, 96, 99];
    if (rain > 0 || precipitation > 0 || precipitationProbability >= 50 || rainyCode.contains(weatherCode)) {
      return 'Take an umbrella today.';
    }
    return 'No umbrella needed right now.';
  }

  String get outdoorAdvice {
    if (temperature >= 35 || feelsLike >= 37) {
      return 'Too hot for outdoor sports. Choose indoor training or go out later.';
    }
    if (temperature <= 15) {
      return 'A bit cold. Wear a jacket if you go outside.';
    }
    if (windSpeed >= 35) {
      return 'Windy today. Be careful with outdoor activities.';
    }
    if (precipitationProbability >= 60) {
      return 'Rain is likely. Outdoor plans may need a backup option.';
    }
    return 'Nice weather for a walk or light outdoor exercise.';
  }
}
