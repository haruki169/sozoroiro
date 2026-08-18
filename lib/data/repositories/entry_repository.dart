import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Value;

import '../../domain/models/daily_theme.dart';
import '../../domain/models/entry.dart';
import '../../domain/models/theme_catalog_entry.dart';
import '../db/app_database.dart';
import '../db/daos/entry_dao.dart';

List<String> _decodeStringList(String json) {
  final decoded = jsonDecode(json) as List<dynamic>;
  return decoded.cast<String>();
}

Entry _mapEntry(EntryWithTheme joined) {
  final catalog = ThemeCatalogEntry(
    id: joined.catalog.id,
    catalogKey: joined.catalog.catalogKey,
    name: joined.catalog.name,
    colorHex: joined.catalog.colorHex,
    seasonTags: _decodeStringList(joined.catalog.seasonTagsJson),
    weatherTags: _decodeStringList(joined.catalog.weatherTagsJson),
    poeticPhrases: _decodeStringList(joined.catalog.poeticPhrasesJson),
  );
  final dailyTheme = DailyTheme(
    id: joined.dailyTheme.id,
    date: joined.dailyTheme.date,
    catalog: catalog,
    poeticPhrase: joined.dailyTheme.poeticPhrase,
  );
  return Entry(
    id: joined.entry.id,
    recordedAt: joined.entry.recordedAt,
    photoPath: joined.entry.photoPath,
    extractedColorHex: joined.entry.extractedColorHex,
    dailyTheme: dailyTheme,
    memo: joined.entry.memo,
    locationLat: joined.entry.locationLat,
    locationLng: joined.entry.locationLng,
    locationRecorded: joined.entry.locationRecorded,
  );
}

class EntryRepository {
  EntryRepository(this._db);

  final AppDatabase _db;

  Future<int> createEntry({
    required File photo,
    required String extractedColorHex,
    required int dailyThemeId,
    String? memo,
    double? lat,
    double? lng,
    required bool locationRecorded,
  }) {
    return _db.entryDao.insertEntry(
      EntriesCompanion.insert(
        recordedAt: DateTime.now(),
        photoPath: photo.path,
        extractedColorHex: extractedColorHex,
        dailyThemeId: dailyThemeId,
        memo: Value(memo),
        locationLat: Value(lat),
        locationLng: Value(lng),
        locationRecorded: Value(locationRecorded),
      ),
    );
  }

  /// 色の日記画面用（日時降順、deletedAt IS NULL）。
  Stream<List<Entry>> watchTimeline() {
    return _db.entryDao.watchTimeline().map(
      (rows) => rows.map(_mapEntry).toList(),
    );
  }

  /// 色の地図画面用（locationRecorded=true かつ deletedAt IS NULL）。
  Future<List<Entry>> fetchWithLocation() async {
    final rows = await _db.entryDao.fetchWithLocation();
    return rows.map(_mapEntry).toList();
  }

  /// グラデーションリボン用（deletedAt IS NULL）。
  Future<List<Entry>> fetchForRibbon(DateTime from, DateTime to) async {
    final rows = await _db.entryDao.fetchForRibbon(from, to);
    return rows.map(_mapEntry).toList();
  }

  Future<void> softDelete(int entryId) {
    return _db.entryDao.softDeleteEntry(entryId);
  }
}
