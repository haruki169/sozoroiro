/// 通知頻度。design.md 5.3節 NotificationScheduler参照。
enum NotificationFrequency {
  off,
  occasionally,
  daily;

  static NotificationFrequency fromDbValue(String value) {
    return NotificationFrequency.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationFrequency.occasionally,
    );
  }

  String get dbValue => name;
}

class AppSettings {
  const AppSettings({
    required this.notificationEnabled,
    required this.notificationFrequency,
    required this.locationFeatureEnabled,
  });

  final bool notificationEnabled;
  final NotificationFrequency notificationFrequency;
  final bool locationFeatureEnabled;

  AppSettings copyWith({
    bool? notificationEnabled,
    NotificationFrequency? notificationFrequency,
    bool? locationFeatureEnabled,
  }) {
    return AppSettings(
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      notificationFrequency:
          notificationFrequency ?? this.notificationFrequency,
      locationFeatureEnabled:
          locationFeatureEnabled ?? this.locationFeatureEnabled,
    );
  }

  static const AppSettings initial = AppSettings(
    notificationEnabled: true,
    notificationFrequency: NotificationFrequency.occasionally,
    locationFeatureEnabled: false,
  );
}
