import 'package:drift/drift.dart' show Value;

import '../../domain/models/app_settings.dart';
import '../db/app_database.dart';

AppSettings _mapSettings(SettingsRow row) {
  return AppSettings(
    notificationEnabled: row.notificationEnabled,
    notificationFrequency: NotificationFrequency.fromDbValue(
      row.notificationFrequency,
    ),
    locationFeatureEnabled: row.locationFeatureEnabled,
  );
}

class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  Stream<AppSettings> watchSettings() {
    return _db.settingsDao.watchSettings().map(_mapSettings);
  }

  Future<void> update(AppSettings settings) {
    return _db.settingsDao.updateSettings(
      SettingsCompanion(
        notificationEnabled: Value(settings.notificationEnabled),
        notificationFrequency: Value(
          settings.notificationFrequency.dbValue,
        ),
        locationFeatureEnabled: Value(settings.locationFeatureEnabled),
      ),
    );
  }
}
