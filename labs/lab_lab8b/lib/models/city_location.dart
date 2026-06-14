class CityLocation {
  final String name;
  final String country;
  final double latitude;
  final double longitude;
  final String timezone;

  const CityLocation({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.timezone,
  });

  factory CityLocation.fromJson(Map<String, dynamic> json) {
    return CityLocation(
      name: json['name']?.toString() ?? 'Unknown city',
      country: json['country']?.toString() ?? 'Unknown country',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timezone: json['timezone']?.toString() ?? 'auto',
    );
  }
}
