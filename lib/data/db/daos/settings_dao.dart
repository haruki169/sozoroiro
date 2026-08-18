import 'package:drift/drift.dart';

import '../app_database.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [Settings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  Stream<SettingsRow> watchSettings() {
    return (select(
      settings,
    )..where((t) => t.id.equals(1))).watchSingleOrNull().asyncMap((row) async {
      if (row != null) return row;
      await into(settings).insert(const SettingsCompanion(id: Value(1)));
      return (select(
        settings,
      )..where((t) => t.id.equals(1))).getSingle();
    });
  }

  Future<void> updateSettings(SettingsCompanion companion) async {
    final existing = await (select(
      settings,
    )..where((t) => t.id.equals(1))).getSingleOrNull();
    if (existing == null) {
      await into(
        settings,
      ).insert(companion.copyWith(id: const Value(1)));
    } else {
      await (update(
        settings,
      )..where((t) => t.id.equals(1))).write(companion);
    }
  }
}
