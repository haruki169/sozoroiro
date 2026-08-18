import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/entry_dao.dart';
import 'daos/settings_dao.dart';
import 'daos/theme_dao.dart';

part 'app_database.g.dart';

/// design.md 4.1節。お題の内容カタログ（静的マスタ）。
class ThemeCatalog extends Table {
  IntColumn get id => integer().autoIncrement()();
  // アセットJSON側の識別子。将来のシード更新・重複防止に使用
  TextColumn get catalogKey => text().unique()();
  TextColumn get name => text()();
  TextColumn get colorHex => text()();
  // JSON配列文字列。例: ["spring","summer"]
  TextColumn get seasonTagsJson => text()();
  // JSON配列文字列。天気非依存は空配列。値の語彙は design.md 4.5節参照
  TextColumn get weatherTagsJson => text()();
  // JSON配列文字列（1件以上）
  TextColumn get poeticPhrasesJson => text()();
}

/// design.md 4.2節。お題の提示履歴（要件定義書7章「お題（Theme）」）。
@DataClassName('DailyThemeRow')
class DailyThemes extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().unique()();
  IntColumn get catalogId => integer().references(ThemeCatalog, #id)();
  // その日実際に表示した添え文言（catalog内バリエーションから確定した1件、以後不変）
  TextColumn get poeticPhrase => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // 論理削除用（確定）。MVPでは削除UIを提供しないため常にnull運用
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

/// design.md 4.3節。記録エントリ（要件定義書7章「記録エントリ（Entry）」）。
@DataClassName('EntryRow')
class Entries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get recordedAt => dateTime()();
  TextColumn get photoPath => text()();
  TextColumn get extractedColorHex => text()();
  IntColumn get dailyThemeId => integer().references(DailyThemes, #id)();
  TextColumn get memo => text().nullable()();
  RealColumn get locationLat => real().nullable()();
  RealColumn get locationLng => real().nullable()();
  // トグルがONだったかどうかを明示保持（座標がnullでも「OFFだった」ことを区別するため）
  BoolColumn get locationRecorded =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

/// design.md 4.4節。アプリ設定（単一行）。
@DataClassName('SettingsRow')
class Settings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  BoolColumn get notificationEnabled =>
      boolean().withDefault(const Constant(true))();
  // "off" | "occasionally"（デフォルト）| "daily"
  TextColumn get notificationFrequency =>
      text().withDefault(const Constant('occasionally'))();
  BoolColumn get locationFeatureEnabled =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [ThemeCatalog, DailyThemes, Entries, Settings],
  daos: [ThemeDao, EntryDao, SettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// テスト用にインメモリDBを直接注入できるコンストラクタ。
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement(
        'CREATE INDEX idx_entries_recorded_at_desc ON entries (recorded_at DESC)',
      );
      await customStatement(
        'CREATE INDEX idx_entries_daily_theme_id ON entries (daily_theme_id)',
      );
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sozoroiro.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
