class Location {
  final double latitude;
  final double longitude;

  const Location({
    required this.latitude,
    required this.longitude,
  })  : assert(latitude >= -90 && latitude <= 90,
            'Latitude must be in an interval from -90.0 to +90.0'),
        assert(longitude >= -180 && latitude <= 180,
            'Longitude must be in an interval from -180.0 to +180.0');

  @override
  String toString() => 'Location($latitude, $longitude)';
}
