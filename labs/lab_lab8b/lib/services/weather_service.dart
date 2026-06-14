import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/city_location.dart';
import '../models/weather_report.dart';

class WeatherService {
  WeatherService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<WeatherReport> fetchWeatherForCity(String cityName) async {
    final location = await _fetchLocation(cityName.trim());
    final encodedTimezone = Uri.encodeComponent(location.timezone);

    final uri = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=${location.latitude}'
      '&longitude=${location.longitude}'
      '&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,rain,weather_code,wind_speed_10m'
      '&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max'
      '&timezone=$encodedTimezone',
    );

    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Could not load weather data. Status: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return WeatherReport.fromJson(location: location, json: data);
  }

  Future<CityLocation> _fetchLocation(String cityName) async {
    if (cityName.isEmpty) {
      throw Exception('Please enter a city name.');
    }

    final uri = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search'
      '?name=${Uri.encodeComponent(cityName)}'
      '&count=1'
      '&language=en'
      '&format=json',
    );

    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Could not search this city. Status: ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final results = data['results'];

    if (results is! List || results.isEmpty) {
      throw Exception('No city found for "$cityName". Try another name.');
    }

    return CityLocation.fromJson(results.first as Map<String, dynamic>);
  }
}
