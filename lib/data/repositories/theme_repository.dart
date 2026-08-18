import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../domain/models/daily_theme.dart';
import '../../domain/models/theme_catalog_entry.dart';
import '../db/app_database.dart';

List<String> _decodeStringList(String json) {
  final decoded = jsonDecode(json) as List<dynamic>;
  return decoded.cast<String>();
}

String _encodeStringList(List<String> list) => jsonEncode(list);

ThemeCatalogEntry _mapCatalog(ThemeCatalogData row) {
  return ThemeCatalogEntry(
    id: row.id,
    catalogKey: row.catalogKey,
    name: row.name,
    colorHex: row.colorHex,
    seasonTags: _decodeStringList(row.seasonTagsJson),
    weatherTags: _decodeStringList(row.weatherTagsJson),
    poeticPhrases: _decodeStringList(row.poeticPhrasesJson),
  );
}

class ThemeRepository {
  ThemeRepository(this._db);

  final AppDatabase _db;

  /// deletedAt IS NULLのもののみ返す。
  Future<DailyTheme?> findByDate(DateTime date) async {
    final row = await _db.themeDao.findDailyThemeByDate(date);
    if (row == null) return null;
    return _joinDailyTheme(row);
  }

  Future<DailyTheme> insertDailyTheme({
    required DateTime date,
    required int catalogId,
    required String poeticPhrase,
  }) async {
    final dayStart = DateTime(date.year, date.month, date.day);
    await _db.themeDao.insertDailyTheme(
      DailyThemesCompanion.insert(
        date: dayStart,
        catalogId: catalogId,
        poeticPhrase: poeticPhrase,
      ),
    );
    final row = await _db.themeDao.findDailyThemeByDate(dayStart);
    return _joinDailyTheme(row!);
  }

  /// [asOf]から遡って直近days日間に選定されたcatalogIdの一覧（ThemeSelectorの重複除外に使用）。
  Future<List<int>> fetchRecentCatalogIds({
    int days = 7,
    required DateTime asOf,
  }) {
    return _db.themeDao.fetchRecentCatalogIds(days: days, asOf: asOf);
  }

  /// 過去のお題一覧。2週間単位のページネーション対応。
  Future<ThemePage> fetchPastThemes({int page = 0, int pageSize = 14}) async {
    final rows = await _db.themeDao.fetchPastThemesPage(
      page: page,
      pageSize: pageSize,
    );
    final items = <DailyTheme>[];
    for (final row in rows) {
      items.add(await _joinDailyTheme(row));
    }
    final total = await _db.themeDao.countPastThemes();
    final hasMore = (page + 1) * pageSize < total;
    return ThemePage(items: items, hasMore: hasMore);
  }

  /// 設定画面「お題一覧の閲覧」用。
  Future<List<ThemeCatalogEntry>> fetchAllCatalog() async {
    final rows = await _db.themeDao.fetchAllCatalog();
    return rows.map(_mapCatalog).toList();
  }

  /// 初回起動時のアセットJSON投入（60件、T-005）。
  Future<void> seedCatalogIfEmpty() async {
    final hasAny = await _db.themeDao.hasAnyCatalogEntries();
    if (hasAny) return;

    final raw = await rootBundle.loadString(
      'assets/data/theme_catalog.json',
    );
    final list = jsonDecode(raw) as List<dynamic>;
    for (final item in list) {
      final map = item as Map<String, dynamic>;
      await _db.themeDao.insertCatalogEntry(
        ThemeCatalogCompanion.insert(
          catalogKey: map['catalogKey'] as String,
          name: map['name'] as String,
          colorHex: map['colorHex'] as String,
          seasonTagsJson: _encodeStringList(
            (map['seasonTags'] as List<dynamic>).cast<String>(),
          ),
          weatherTagsJson: _encodeStringList(
            (map['weatherTags'] as List<dynamic>).cast<String>(),
          ),
          poeticPhrasesJson: _encodeStringList(
            (map['poeticPhrases'] as List<dynamic>).cast<String>(),
          ),
        ),
      );
    }
  }

  Future<void> softDelete(int dailyThemeId) {
    return _db.themeDao.softDeleteDailyTheme(dailyThemeId);
  }

  Future<DailyTheme> _joinDailyTheme(DailyThemeRow row) async {
    final catalogRow = await _db.themeDao.findCatalogById(row.catalogId);
    return DailyTheme(
      id: row.id,
      date: row.date,
      catalog: _mapCatalog(catalogRow!),
      poeticPhrase: row.poeticPhrase,
    );
  }
}
