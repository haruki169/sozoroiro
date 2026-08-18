import 'package:drift/drift.dart';

import '../app_database.dart';

part 'theme_dao.g.dart';

@DriftAccessor(tables: [ThemeCatalog, DailyThemes])
class ThemeDao extends DatabaseAccessor<AppDatabase> with _$ThemeDaoMixin {
  ThemeDao(super.db);

  Future<int> insertCatalogEntry(ThemeCatalogCompanion entry) {
    return into(themeCatalog).insert(entry, mode: InsertMode.insertOrIgnore);
  }

  Future<bool> hasAnyCatalogEntries() async {
    final row = await (select(themeCatalog)..limit(1)).getSingleOrNull();
    return row != null;
  }

  Future<List<ThemeCatalogData>> fetchAllCatalog() {
    return (select(themeCatalog)..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<ThemeCatalogData?> findCatalogById(int id) {
    return (select(
      themeCatalog,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// deletedAt IS NULLのもののみ返す。
  Future<DailyThemeRow?> findDailyThemeByDate(DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day);
    return (select(dailyThemes)..where(
          (t) => t.date.equals(dayStart) & t.deletedAt.isNull(),
        ))
        .getSingleOrNull();
  }

  Future<int> insertDailyTheme(DailyThemesCompanion entry) {
    return into(dailyThemes).insert(entry);
  }

  /// [asOf]から遡って直近[days]日間に選定されたcatalogIdの一覧（重複除外用）。
  Future<List<int>> fetchRecentCatalogIds({
    required int days,
    required DateTime asOf,
  }) async {
    final since = asOf.subtract(Duration(days: days));
    final query = select(dailyThemes)
      ..where((t) => t.date.isBiggerOrEqualValue(since) & t.deletedAt.isNull());
    final rows = await query.get();
    return rows.map((r) => r.catalogId).toList();
  }

  /// 2週間単位ページネーション（page=0が直近14日）。deletedAt IS NULLのみ。
  Future<List<DailyThemeRow>> fetchPastThemesPage({
    required int page,
    required int pageSize,
  }) {
    final query = select(dailyThemes)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm.desc(t.date)])
      ..limit(pageSize, offset: page * pageSize);
    return query.get();
  }

  Future<int> countPastThemes() async {
    final count = countAll();
    final query = selectOnly(dailyThemes)
      ..addColumns([count])
      ..where(dailyThemes.deletedAt.isNull());
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<void> softDeleteDailyTheme(int id) {
    return (update(dailyThemes)..where((t) => t.id.equals(id))).write(
      DailyThemesCompanion(deletedAt: Value(DateTime.now())),
    );
  }
}
