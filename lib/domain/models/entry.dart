import 'daily_theme.dart';

class Entry {
  const Entry({
    required this.id,
    required this.recordedAt,
    required this.photoPath,
    required this.extractedColorHex,
    required this.dailyTheme,
    this.memo,
    this.locationLat,
    this.locationLng,
    required this.locationRecorded,
  });

  final int id;
  final DateTime recordedAt;
  final String photoPath;
  final String extractedColorHex;
  final DailyTheme dailyTheme;
  final String? memo;
  final double? locationLat;
  final double? locationLng;
  final bool locationRecorded;
}
