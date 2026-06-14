import 'package:flutter/material.dart';

import '../models/weather_report.dart';
import '../services/weather_service.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController(text: 'Hanoi');

  late Future<WeatherReport> _weatherFuture;
  String _lastCity = 'Hanoi';

  @override
  void initState() {
    super.initState();
    _weatherFuture = _weatherService.fetchWeatherForCity(_lastCity);
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _searchWeather() {
    final city = _cityController.text.trim();
    if (city.isEmpty) return;

    setState(() {
      _lastCity = city;
      _weatherFuture = _weatherService.fetchWeatherForCity(city);
    });
  }

  void _retry() {
    setState(() {
      _weatherFuture = _weatherService.fetchWeatherForCity(_lastCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 8B - Weather Companion'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _SearchBar(
                controller: _cityController,
                onSearch: _searchWeather,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<WeatherReport>(
                  future: _weatherFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const _LoadingView();
                    }

                    if (snapshot.hasError) {
                      return _ErrorView(
                        message: snapshot.error.toString(),
                        onRetry: _retry,
                      );
                    }

                    if (!snapshot.hasData) {
                      return _ErrorView(
                        message: 'No weather data found.',
                        onRetry: _retry,
                      );
                    }

                    return _WeatherContent(report: snapshot.data!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.onSearch,
  });

  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => onSearch(),
            decoration: InputDecoration(
              labelText: 'City or region',
              hintText: 'Example: Hanoi, Tokyo, Bangkok',
              prefixIcon: const Icon(Icons.location_city),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: onSearch,
          icon: const Icon(Icons.search),
          label: const Text('Search'),
        ),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading weather data...'),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 56),
              const SizedBox(height: 12),
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherContent extends StatelessWidget {
  const _WeatherContent({required this.report});

  final WeatherReport report;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _MainWeatherCard(report: report),
        const SizedBox(height: 12),
        _RecommendationCard(report: report),
        const SizedBox(height: 12),
        _DetailGrid(report: report),
      ],
    );
  }
}

class _MainWeatherCard extends StatelessWidget {
  const _MainWeatherCard({required this.report});

  final WeatherReport report;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  report.weatherIcon,
                  style: const TextStyle(fontSize: 56),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${report.location.name}, ${report.location.country}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(report.weatherDescription),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              '${report.temperature.toStringAsFixed(1)}°C',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'Feels like ${report.feelsLike.toStringAsFixed(1)}°C',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({required this.report});

  final WeatherReport report;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb_outline),
                const SizedBox(width: 8),
                Text(
                  'Today recommendation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('☂️ ${report.umbrellaAdvice}'),
            const SizedBox(height: 8),
            Text('🏃 ${report.outdoorAdvice}'),
          ],
        ),
      ),
    );
  }
}

class _DetailGrid extends StatelessWidget {
  const _DetailGrid({required this.report});

  final WeatherReport report;

  @override
  Widget build(BuildContext context) {
    final details = [
      _WeatherDetail('Humidity', '${report.humidity}%', Icons.water_drop_outlined),
      _WeatherDetail('Wind', '${report.windSpeed.toStringAsFixed(1)} km/h', Icons.air),
      _WeatherDetail('Rain', '${report.rain.toStringAsFixed(1)} mm', Icons.umbrella_outlined),
      _WeatherDetail('Rain chance', '${report.precipitationProbability}%', Icons.cloudy_snowing),
      _WeatherDetail('Max temp', '${report.todayMaxTemp.toStringAsFixed(1)}°C', Icons.arrow_upward),
      _WeatherDetail('Min temp', '${report.todayMinTemp.toStringAsFixed(1)}°C', Icons.arrow_downward),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: details.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.55,
      ),
      itemBuilder: (context, index) {
        final item = details[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon),
                const SizedBox(height: 10),
                Text(item.label),
                const SizedBox(height: 4),
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WeatherDetail {
  const _WeatherDetail(this.label, this.value, this.icon);

  final String label;
  final String value;
  final IconData icon;
}
